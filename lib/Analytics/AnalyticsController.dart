import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/di.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsController{
  final UserController userController;
  late UserStateController userStateController;

  late Map<String, Object> defaultParams;

  AnalyticsController({required this.userController});

  Future<void> initAsync() async{
    userStateController = getIt.get<UserStateController>();

    defaultParams = {
      "userId": userController.userId,
      "sessionId": userController.sessionId
    };

    await FirebaseAnalytics.instance
        .setDefaultEventParameters(defaultParams);
  }

  Future<void> logEventAsync(String eventName, {Map<String, Object>? params}) async{
    var eventParams = await _wrapWithAmbientContextAsync(params);

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