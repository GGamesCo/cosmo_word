import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/Flame/TimeChallengeGame.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IFlowRepository.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/Models/InputAcceptedEventArgs.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeChallengeResults.dart';
import 'package:cosmo_word/Screens/GameScreen/GameScreen.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/PopupManager.dart';
import 'package:event/event.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import '../Common/Abstract/IGameState.dart';
import '../UserStateController.dart';

@Injectable()
class TimeAtackStage extends IGameStage {
  final UserStateController userStateController;
  final RocketChallengeConfig challengeConfig;
  final IWordInputController wordInputController;
  final ITimerController timerController;
  final IBalanceController balanceController;
  final IWordRepository wordRepository;
  final SoundsController soundsController;
  late TimeChallengeGame gameUi;

  bool isActive = false;

  @override
  GameStage get state => GameStage.TimeAtack;

  @override
  Widget get root => GameScreen(game: gameUi, gameScreenKey: GlobalKey());

  TimeAtackStage({
    required this.userStateController,
    required this.wordRepository,
    required this.wordInputController,
    required this.timerController,
    required this.challengeConfig,
    required this.balanceController,
    required this.soundsController
  });

  late AudioPlayer player;

  @override
  Future initAsync() async {
    var flowSets = wordRepository.sets.map((e) => WordSetFlowItem(setId: e.id, requiredWordsCount: Random().nextInt(1 + (e.words.length - 1)))).toList();

    var flow = WordSetFlow(id: 99999, title: "Time Challenge", sets: flowSets);
    wordInputController.initializeAsync(flow);
    wordInputController.onInputAccepted.subscribe(onInputCompleted);
    timerController.timeIsOverEvent.subscribe(onTimeIsOver);
    timerController.timerUpdatedEvent.subscribe(onTimeTick);

    gameUi = TimeChallengeGame(challengeConfig: challengeConfig, timerController: timerController, wordInputController: wordInputController, soundsController: soundsController);
    player = AudioPlayer();
  }

  void start() {
    timerController.start(challengeConfig.totalTimeSec, challengeConfig.wordCompletionTimeRewardSec);
    isActive = true;
  }

  void pause() {
    isActive = false;
    timerController.pause();
  }

  void resume() {
    isActive = true;
    timerController.resume();
  }

  void terminate(){
    isActive = false;
    timerController.stop();
    wordInputController.reset();
  }

  void onInputCompleted(InputAcceptedEventArgs? args){
    if(isActive){
      timerController.addStep(challengeConfig.wordCompletionTimeRewardSec);
    }
    else
      print("Error. Input completed after game paused.");
  }

  void onTimeIsOver(Value<int>? args) async {
    print("handleGameCompletion..");
    player.stop();
    isActive = false;
    timerController.stop();
    var rewardCoins = wordInputController.flowState.completedWordsInFlow * 5;
    var record = await userStateController.getRocketRecord();
    var results = TimeChallengeResults(
      reachedHeight: gameUi.currentReachedHeight.toInt(),
      coinReward: rewardCoins,
      lastRecord: record
    );
    PopupManager.ShowTimeChallengeCompletePopup(results);
    balanceController.addBalanceAsync(rewardCoins);
    if(results.reachedHeight > record) {
      userStateController.setRocketRecord(results.reachedHeight);
    }
  }

  void onTimeTick(Value<int>? args) {
    playSoundIfHurry();
  }

  void playSoundIfHurry() async {
    if (timerController.timeLeftSec <= 5 && player.state != PlayerState.PLAYING){
      var uri = await AudioCache().load("audio/"+SoundsController.CLOCK);
      player.play(uri.toString(), volume: 0.3);
    }else if(timerController.timeLeftSec > 5){
      player.stop();
    }
  }

  void onDispose(){
    wordInputController.onDispose();
    timerController.onDispose();
    player.dispose();

    terminate();
    gameUi.dispose();
  }
}
