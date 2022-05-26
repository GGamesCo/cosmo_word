import 'dart:async';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/LobbyScreen/LobbyScreen.dart';
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