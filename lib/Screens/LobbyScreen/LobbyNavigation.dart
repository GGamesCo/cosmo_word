import 'package:cosmo_word/GameBL/TimeChallenge/TimeGameController.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Flame/StoryGame.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../GameBL/Story/StoryLevelConfig.dart';
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
              Image.asset('assets/images/lobby/lobby-navigation-block.png'),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
              )
            ]
        ),
      ),
    );
  }

  void _navigateToStoryGame(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen(
          gameScreenKey: GlobalKey(),
          game: StoryGame(
              storyLevelConfig: StoryLevelConfig(
                levelNumber: 4,
                totalWords: 10
              )
          )
      )
      ),
    );
  }

  void _navigateToChallengeGame(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen(
          gameScreenKey: GlobalKey(),
          game: TimeChallengeGame(gameController: getIt.get<TimeGameController>())
      )
      ),
    );
  }
}