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
      name: "ggames-cosmo-word",
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
    return MaterialApp(
        title: 'Trial',
        home: Scaffold(
            body: new MyHome()));
  }
}

class MyHome extends StatelessWidget { // Wrapper Widget
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => showAlert(context));
    return Stack(
      children: [
        new Container(
            child: new Stack(
                children: <Widget>[

                  Container(width: double.infinity,
                      child: Image(image: const AssetImage("assets/bg.jpg"), fit: BoxFit.fill)),

                  new Container(
                    alignment: AlignmentDirectional.center,
                    // decoration: new BoxDecoration(
                    //   color: Colors.white70,
                    // ),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: new BorderRadius.circular(10.0)
                      ),
                      width: 200.0,
                      height: 150.0,
                      alignment: AlignmentDirectional.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Center(
                            child: new SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: new CircularProgressIndicator(
                                value: null,
                                strokeWidth: 7.0,
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(top: 25.0),
                            child: new Center(
                              child: new Text(
                                "loading..",
                                style: new TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ])
        )],
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Text("You are lucky!\nYour bonus is 20 free suggestions!\nWe will send you push once journey is ready."),

        ));
  }
}

class SpaceShooterGame extends FlameGame with PanDetector, HasTappables {
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