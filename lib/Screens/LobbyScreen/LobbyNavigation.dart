import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeAtackStage.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/GameCompletePopup.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../Flame/StoryGame.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../GameBL/Story/StoryStateController.dart';
import '../../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import '../GameScreen/GameScreen.dart';
import 'LobbyNavigationButton.dart';

class LobbyNavigation extends StatelessWidget{

  LobbyNavigation();

  @override
  Widget build(BuildContext context){
    return Container(
      child: IntrinsicHeight(
        child: Stack(
            children: [
              Center(child: Image.asset('assets/images/lobby/lobby-navigation-block.png')),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LobbyNavigationButton(
                        onTap: () => _navigateToStoryGame(context),
                        imageFileName: 'assets/images/lobby/lobby-navigation-goto-mystory.png',
                      ),
                      LobbyNavigationButton(
                        onTap: () => _navigateToChallengeGame(context),
                        imageFileName: 'assets/images/lobby/lobby-navigation-goto-timechalenge.png',
                      )
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

  void _navigateToStoryGame(BuildContext context){
    getIt.get<StageManager>().navigateToStage(GameStage.Story, context);
  }

  void _navigateToChallengeGame(BuildContext context){
    getIt.get<StageManager>().navigateToStage(GameStage.TimeAtack, context);
  }
}