import 'package:cosmo_word/Analytics/AnalyticsServiceApi.dart';
import 'package:cosmo_word/Analytics/MixpanelTracker.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/di.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsController{
  final UserController userController;
  final AnalyticsServiceApi analyticsServiceApi;
  final MixpanelTracker mixpanelTracker;
  late UserStateController userStateController;

  late Map<String, Object> defaultParams;

  AnalyticsController({
    required this.userController,
    required this.analyticsServiceApi,
    required this.mixpanelTracker
  });

  Future<void> initAsync() async{
    userStateController = getIt.get<UserStateController>();

    defaultParams = {
      "localDateTime": DateTime.now().toString(),
      "userId": userController.userId,
      "sessionId": userController.sessionId,
    };

    await mixpanelTracker.initAsync(userController.userId);
    await FirebaseAnalytics.instance
        .setDefaultEventParameters(defaultParams);

    FirebaseAnalytics.instance.setUserId(id: userController.userId);
    FirebaseAnalytics.instance.setUserProperty(name: "sessionId",  value: userController.sessionId);

    await analyticsServiceApi.initAsync().timeout(Duration(seconds: 10), onTimeout: () => {});
  }

  Future<void> logEventAsync(String eventName, {Map<String, Object>? params}) async{
    var eventParams = await _wrapWithAmbientContextAsync(params);
    mixpanelTracker.track(eventName, params: eventParams);
    await analyticsServiceApi.sendEvent(eventName, eventParams);
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: eventParams);
  }

  Future<Map<String, Object>> _wrapWithAmbientContextAsync(Map<String, Object>? params) async {
    var eventParams = {...defaultParams};

    var currentStoryState = await userStateController.getStoryState();

    eventParams.addAll({"levelNumber" : currentStoryState.currentLevelNumber});
    eventParams.addAll({"levelId" : currentStoryState.currentLevelNumber});

    if(params != null){
      eventParams.addAll(params);
    }

    return eventParams;
  }
}