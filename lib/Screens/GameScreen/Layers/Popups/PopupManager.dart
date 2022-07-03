import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/GameBL/Common/GameEventBus.dart';
import 'package:cosmo_word/GameBL/Events/EventBusEvents.dart';
import 'package:cosmo_word/GameBL/Story/StoryLevelCompleteResult.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/OutOfCoinsPopup.dart';
import 'package:cosmo_word/di.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import '../../../../GameBL/Services/UserStateService/UserStateService.dart';
import '../../../../GameBL/TimeChallenge/TimeChallengeResults.dart';
import '../../../../main.dart';
import 'GameCompletePopup.dart';

class PopupManager {

  static final UserStateService storyStateService = getIt.get<UserStateService>();

  static Future ShowLevelCompletePopup(StoryLevelCompleteResult resultsData) async {
    await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.STORY_COMPLETE_POPUP_SHOW, params: {"coinReward": resultsData.coinReward});

    await FlameAudio.play(SoundsController.WIN_APPLAUSE);
    var storyState = await storyStateService.getStoryState();
    await showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => false,
          child: GameCompletePopup(
            popupType: 1,
            storyStateModel: storyState,
            completedLevelId: resultsData.completedLevelId,
            coinReward: resultsData.coinReward,
          ),
        );
      }
    );

    await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.STORY_COMPLETE_POPUP_CLOSE);
  }

  static Future ShowTimeChallengeCompletePopup(TimeChallengeResults resultsData) async {
    if (resultsData.coinReward > 0){
      await FlameAudio.play(SoundsController.WIN_APPLAUSE);
    }else{
      await FlameAudio.play(SoundsController.WIN_SIMPLE);
    }

    await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.CHALLENGE_COMPLETE_POPUP_SHOW, params: {
      "coinReward": resultsData.coinReward,
      "lastRecord": resultsData.lastRecord,
      "completedWordsCount": resultsData.completedWordsCount,
      "reachedHeight": resultsData.reachedHeight
    });

    var storyState = await storyStateService.getStoryState();
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context){
        return WillPopScope(
          onWillPop: () async => false,
          child: GameCompletePopup(
            popupType: 2,
            storyStateModel: storyState,
            completedLevelId: 0,
            coinReward: resultsData.coinReward,
            timeChallengeResults: resultsData,
          ),
        );
      }
    );
    await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.CHALLENGE_COMPLETE_POPUP_CLOSE);
  }

  static Future NotEnoughMoneyPopup() async {
    await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.OUT_COINS_POPUP_SHOW);
    mainEventBus.fire(OutOfCoinsPopupShowing());
    try{
      await showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context){
            return OutOfCoinsPopup();
          }
      );
    }finally{
      mainEventBus.fire(OutOfCoinsPopupClosed());
      await getIt.get<AnalyticsController>().logEventAsync(AnalyticEvents.OUT_COINS_POPUP_CLOSE);
    }
  }

}