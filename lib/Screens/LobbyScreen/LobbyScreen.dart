import 'package:flutter/material.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import '../Common/Background/StaticBackground.dart';
import '../GameScreen/GameScreen.dart';
import 'LobbyLogo.dart';
import 'LobbyMyStory.dart';
import 'LobbyNavigation.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StaticBackground(fileName: 'green.jpg'),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 100,
              bottom: 0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LobbyLogo(),
                LobbyNavigation(),
                LobbyMyStory()
              ]
            ),
          )
        ],
        ),
      );
  }
}