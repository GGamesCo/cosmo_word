import 'package:cosmo_word/GameBL/Story/StoryLevelCompleteResult.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/OutOfCoinsPopup.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateService.dart';
import '../../../../GameBL/TimeChallenge/TimeChallengeResults.dart';
import '../../../../main.dart';
import 'GameCompletePopup.dart';

class PopupManager {

  static final StoryStateService storyStateService = getIt.get<StoryStateService>();

  static Future ShowLevelCompletePopup(StoryLevelCompleteResult resultsData) async {
    var storyState = await storyStateService.getStoryState();
    return showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context){
        return GameCompletePopup(
          popupType: 1,
          storyStateModel: storyState,
          coinReward: resultsData.coinReward,
        );
      }
    );
  }

  static Future ShowTimeChallengeCompletePopup(TimeChallengeResults resultsData) async {
    var storyState = await storyStateService.getStoryState();
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context){
        return GameCompletePopup(
          popupType: 2,
          storyStateModel: storyState,
          coinReward: resultsData.coinReward,
        );
      }
    );
  }

  static Future NotEnoughMoneyPopup() async {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context){
          return OutOfCoinsPopup();
        }
    );
  }

}