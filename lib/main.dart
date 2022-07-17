import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Analytics/SegmentationController.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/Configs/GameConfigController.dart';
import 'package:cosmo_word/GameBL/Services/UserStateService/UserStateService.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/MyAppWidget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'di.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';
import 'package:universal_io/io.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final delayForWebRendering = 600;

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
bool isTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide < 550;

// KeyHash:
// keytool -exportcert -alias YOUR_RELEASE_KEY_ALIAS -keystore YOUR_RELEASE_KEY_PATH | openssl sha1 -binary | openssl base64
// eKJJHinr+D3pnrXYFuIJnPbO7ag=

void main() async {

  //Should be before any DI resolves
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  if(!kIsWeb) {
    await initializeFirebase();
  }

  initializeAppsflyer();

  await initDiInstances();

  var stageManager = getIt.get<StageManager>();
  await stageManager.initAsync();

  getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.APP_START);

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MyAppWidget(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Word Rambo',
            home: stageManager.currentStage.root,
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
          )
        );
      }
    ),
  );
}

Future initDiInstances() async {
  // Must be first init
  var segmentationController = getIt.get<SegmentationController>();
  await segmentationController.initAsync().timeout(Duration(seconds: 10),onTimeout: () => {});

  var userController = getIt.get<UserController>();
  await userController.initAsync();

  var analytics = getIt.get<AnalyticsController>();
  await analytics.initAsync();

  var userStateService = getIt.get<UserStateService>();
  userStateService.init();
  
  var gameConfigController = getIt.get<GameConfigController>();
  await gameConfigController.initAsync();

  var stageManager = getIt.get<StageManager>();
  await stageManager.initAsync();
}

Future<void> initializeFirebase() async {
  if (Firebase.apps.isEmpty) {
    WidgetsFlutterBinding.ensureInitialized();

    var firebaseApp = await Firebase.initializeApp(
      name: "ggames-cosmo-word",
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      print("completedAppInitialize");
    });
  }
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