import 'package:cosmo_word/Flame/TimeChallengeGame.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Common/Models/InputAcceptedEventArgs.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'package:cosmo_word/Screens/GameScreen/GameScreen.dart';
import 'package:event/event.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';
import '../Common/Abstract/IGameState.dart';

@Injectable()
class TimeAtackStage extends IGameStage {
  final RocketChallengeConfig challengeConfig;
  final IWordInputController wordInputController;
  final ITimerController timerController;
  final IBalanceController balanceController;
  late TimeChallengeGame gameUi;

  bool isActive = false;

  @override
  GameStage get state => GameStage.TimeAtack;

  @override
  Widget get root => GameScreen(game: gameUi, gameScreenKey: GlobalKey());

  TimeAtackStage({required this.wordInputController, required this.timerController,
  required this.challengeConfig, required this.balanceController});

  @override
  Future initAsync() async {
    wordInputController.initializeAsync(3);
    wordInputController.onInputAccepted.subscribe(onInputCompleted);
    timerController.timeIsOverEvent.subscribe(onTimeIsOver);

    gameUi = TimeChallengeGame(challengeConfig: challengeConfig, timerController: timerController, wordInputController: wordInputController);
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

  Future handleGameCompletionAsync(int timeSpent) async{
    print("handleGameCompletion..");
    isActive = false;
    timerController.stop();
    var rewardCoins = wordInputController.flowState.completedWordsInFlow * 5;
    balanceController.addBalanceAsync(rewardCoins);
  }

  void onInputCompleted(InputAcceptedEventArgs? args){
    if(isActive)
      timerController.addStep(challengeConfig.wordCompletionTimeRewardSec);
    else
      print("Error. Input completed after game paused.");
  }

  void onTimeIsOver(Value<int>? args){
    handleGameCompletionAsync(args!.value);
  }

  void onDispose(){
    wordInputController.onDispose();
    timerController.onDispose();

    terminate();
    gameUi.dispose();
  }
}
