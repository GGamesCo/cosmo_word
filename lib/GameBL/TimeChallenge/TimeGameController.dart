import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class TimeGameController{
  final RocketChallengeConfig challengeConfig;
  final IWordInputController wordInputController;
  final ITimerController timerController;
  final IBalanceController balanceController;

  TimeGameController({required this.wordInputController, required this.timerController,
  required this.challengeConfig, required this.balanceController});

  Future initAsync() async {
    wordInputController.onInputAccepted.subscribe((args) => timerController.addStep(challengeConfig.wordCompletionTimeRewardSec));
    timerController.timeIsOverEvent.subscribe((args) => handleGameCompletionAsync(args!.value));
  }

  void startGame() => timerController.start(challengeConfig.totalTimeSec, challengeConfig.wordCompletionTimeRewardSec);

  void pauseGame() => timerController.pause();

  void resumeGame() => timerController.resume();

  void terminateGame(){
    timerController.stop();
  }

  Future handleGameCompletionAsync(int timeSpent) async{
    print("handleGameCompletion..");
    timerController.stop();
    var rewardCoins = wordInputController.completedWordsCount * timeSpent;
    balanceController.addBalanceAsync(rewardCoins);
  }
}
