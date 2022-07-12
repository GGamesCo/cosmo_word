import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Analytics/MixpanelTracker.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/di.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

@singleton
class AnalyticsController{
  final UserController userController;
  final MixpanelTracker mixpanelTracker;
  late UserStateController userStateController;

  late Map<String, Object> defaultParams;

  AnalyticsController({required this.userController, required this.mixpanelTracker});

  Future<void> initAsync() async{
    userStateController = getIt.get<UserStateController>();

    defaultParams = {
      "localDateTime": DateTime.now().toString(),
      "userId": userController.userId,
      "sessionId": userController.sessionId,
    };

    await mixpanelTracker.initAsync(userController.userId);
    await FirebaseAnalytics.instance.setDefaultEventParameters(defaultParams);

    FirebaseAnalytics.instance.setUserId(id: userController.userId);
    FirebaseAnalytics.instance.setUserProperty(name: "sessionId",  value: userController.sessionId);
  }

  Future<void> logEventAsync(String eventName, {Map<String, Object>? params}) async{
    var eventParams = await _wrapWithAmbientContextAsync(params);
    await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: eventParams);
    mixpanelTracker.track(eventName, params: eventParams);
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