import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'Flame/Controllers/GameScreenController.dart';
import 'Flame/Controllers/StubGame/StubChallengeZoneController.dart';
import 'Flame/Controllers/StubGame/StubInputDisplayController.dart';
import 'Flame/Controllers/StubGame/StubUserInputController.dart';
import 'Screens/LobbyScreen.dart';
import 'firebase_options.dart';

void main() async {

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

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: LobbyScreen(),
  ));
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