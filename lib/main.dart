import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:cosmo_word/Controllers/StubGame/StubChallengeZoneController.dart';
import 'package:cosmo_word/Controllers/StubGame/StubInputDisplayController.dart';
import 'package:cosmo_word/Controllers/StubGame/StubUserInputController.dart';
import 'package:cosmo_word/UiComponents/Scene.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'Controllers/GameScreenController.dart';
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

  runApp(new MyApp());
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: SpaceShooterGame());
  }
}

class SpaceShooterGame extends FlameGame with PanDetector, HasTappables, HasCollisionDetection {
  late Scene wordBrick;

  @override
  Future<void>? onLoad() {
    var gameScreenController = GameScreenController(
        userInputController: StubUserInputController(),
        challengeController: StubChallengeZoneController(),
        inputDisplayController: StubInputDisplayController()
    );
    gameScreenController.init();
    add(gameScreenController.rootUiControl);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    wordBrick.move(info.delta.game);
  }
}