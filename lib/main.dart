import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/Story/UserStateController.dart';
import 'package:cosmo_word/MyAppWidget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'di.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
bool isTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide < 550;

void main() async {

  configureDependencies();

  // Firebase initialization
  if (Firebase.apps.isEmpty) {
    WidgetsFlutterBinding.ensureInitialized();

    var firebaseApp = await Firebase.initializeApp(
      name: "ggames-cosmo-word",
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      print("completedAppInitialize");
    });
  }

  initializeAppsflyer();
  await initDiInstances();

  var stageManager = getIt.get<StageManager>();
  await stageManager.initAsync();

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MyAppWidget(child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Word Rambo',
          home: stageManager.currentStage.root,
        )
        );
      }
    ),
  );
}

Future initDiInstances() async {
  await (getIt.get<UserStateController>()).initAsync();

  var stageManager = getIt.get<StageManager>();
  await stageManager.initAsync();

  var userController = getIt.get<UserController>();
  await userController.initAsync();

  var analytics = getIt.get<AnalyticsController>();
  await analytics.initAsync();
  analytics.logEventAsync("test_event");
}

void initializeAppsflyer(){
  AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "MeYXSnbosTs2hTceWK9U6Q",
      showDebug: true);

  AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true
  );
}