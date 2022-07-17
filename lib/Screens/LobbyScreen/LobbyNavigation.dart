import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/Services/StoryLevelsService/StoryLevelsService.dart';
import 'package:cosmo_word/GameBL/Services/StoryLocationsService/StoryLocationsService.dart';
import 'package:cosmo_word/GameBL/Services/UserStateService/UserStateService.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeAtackStage.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/GameCompletePopup.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../Flame/StoryGame.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../GameBL/UserStateController.dart';
import '../../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import '../GameScreen/GameScreen.dart';
import 'LobbyNavigationButton.dart';

class LobbyNavigation extends StatefulWidget{

  late UserStateController userStateController;
  late StoryLocationsService storyLocationsService;

  LobbyNavigation(){
    userStateController = getIt.get<UserStateController>();
    storyLocationsService = getIt.get<StoryLocationsService>();
  }

  @override
  State<LobbyNavigation> createState() => _LobbyNavigationState();
}

class _LobbyNavigationState extends State<LobbyNavigation> {

  late dynamic storyData = null;
  late dynamic timeChallengeData = null;
  late AnalyticsController analyticsController;
  
  @override
  void initState() {
    super.initState();

    analyticsController = getIt.get<AnalyticsController>();
    widget.userStateController.getStoryState().then((storyState) async {
      var location = await widget.storyLocationsService.getLocationConfigByLevelId(storyState.currentLevelId);
      var data = {'levelNumber': storyState.currentLevelId, 'locationTitle': location.title};
      if(kIsWeb) {
        await Future.delayed(Duration(milliseconds: 400));
      }
      setState((){
        storyData = data;
      });
    });

    widget.userStateController.getRocketRecord().then((value) async {
      if(kIsWeb) {
        await Future.delayed(Duration(milliseconds: 400));
      }
      setState((){
        timeChallengeData = {'timeChallengeRecord' : value};
      });
    });
  }

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
                      if(storyData != null) ...[
                        LobbyNavigationButton(
                          onTap: () => _navigateToStoryGame(context),
                          title1: "MY STORY",
                          title2: "LEVEL ${storyData['levelNumber']} - ${storyData['locationTitle']}",
                          fontColor: Color.fromRGBO(107, 160, 22, 1),
                          buttonIcon: 'assets/images/lobby/story-btn-icon.png',
                          buttonBg: 'assets/images/lobby/lobby-navigation-goto-mystory.png',
                        ),
                      ],
                      if(timeChallengeData != null) ...[
                        LobbyNavigationButton(
                          onTap: () => _navigateToChallengeGame(context),
                          title1: "CHALLENGE",
                          title2: "Can you hit your record? (${timeChallengeData['timeChallengeRecord']}m)",
                          fontColor: Color.fromRGBO(209, 129, 30, 1),
                          buttonIcon: 'assets/images/lobby/time-challenge-btn-icon.png',
                          buttonBg: 'assets/images/lobby/lobby-navigation-goto-timechalenge.png',
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }

  Future<void> _navigateToStoryGame(BuildContext context) async {
    getIt.get<StageManager>().navigateToStage(GameStage.Story, context);
  }

  void _navigateToChallengeGame(BuildContext context){
    getIt.get<StageManager>().navigateToStage(GameStage.TimeAtack, context);
  }
}