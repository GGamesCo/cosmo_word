import 'package:cosmo_word/Analytics/AnalyticsServiceApi.dart';
import 'package:cosmo_word/Analytics/MixpanelTracker.dart';
import 'package:cosmo_word/Analytics/SegmentationController.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/di.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@singleton
class AnalyticsController{
  final UserController userController;
  final AnalyticsServiceApi analyticsServiceApi;
  final MixpanelTracker mixpanelTracker;
  final SegmentationController segmentationController;
  late UserStateController userStateController;

  late Map<String, Object> defaultParams;

  AnalyticsController({
    required this.userController,
    required this.analyticsServiceApi,
    required this.mixpanelTracker,
    required this.segmentationController
  });

  Future<void> initAsync() async{
    userStateController = getIt.get<UserStateController>();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    defaultParams = {
      "localDateTime": DateTime.now().toString(),
      "userId": userController.userId,
      "sessionId": userController.sessionId,
      "realAppVersion" : packageInfo.version,
      "isWeb": kIsWeb
    };

    if (segmentationController.isEnabled(FeatureType.mixpanelTracker))
      await mixpanelTracker.initAsync(userController.userId);

    if (segmentationController.isEnabled(FeatureType.analytics))
      await analyticsServiceApi.initAsync().timeout(Duration(seconds: 10), onTimeout: () => {});

    if(!kIsWeb) {
      FirebaseAnalytics.instance.setUserId(id: userController.userId);
      FirebaseAnalytics.instance.setUserProperty(
        name: "sessionId", value: userController.sessionId);

      // Error: UnimplementedError: setDefaultEventParameters() is not supported on web
      await FirebaseAnalytics.instance.setDefaultEventParameters(defaultParams);
    }
  }

  Future<void> logEventAsync(String eventName, {Map<String, Object>? params}) async{
    var eventParams = await _wrapWithAmbientContextAsync(params);

    if (segmentationController.isEnabled(FeatureType.mixpanelTracker))
      mixpanelTracker.track(eventName, params: eventParams);
    if (segmentationController.isEnabled(FeatureType.analytics))
      await analyticsServiceApi.sendEvent(eventName, eventParams);

    if(!kIsWeb) {
      await FirebaseAnalytics.instance.logEvent(name: eventName, parameters: eventParams);
    }
  }

  Future<Map<String, Object>> _wrapWithAmbientContextAsync(Map<String, Object>? params) async {
    var eventParams = {...defaultParams};

    var currentStoryState = await userStateController.getStoryState();

    eventParams.addAll({"levelId" : currentStoryState.currentLevelId});

    if(params != null){
      eventParams.addAll(params);
    }

    return eventParams;
  }
}