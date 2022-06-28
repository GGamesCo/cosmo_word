import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/Common/UserController.dart';
import 'package:cosmo_word/GameBL/Story/StoryStateController.dart';
import 'package:cosmo_word/MyAppWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/LobbyScreen/LobbyScreen.dart';
import 'di.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {

  configureDependencies();

  // Firebase initialization
  if (Firebase.apps.isEmpty) {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      name: "cosmo-word",
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
  await (getIt.get<StoryStateController>()).initAsync();

  var stageManager = getIt.get<StageManager>();
  await stageManager.initAsync();

  var userController = getIt.get<UserController>();
  await userController.initAsync();
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