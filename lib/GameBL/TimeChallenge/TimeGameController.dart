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

  bool isActive = false;

  TimeGameController({required this.wordInputController, required this.timerController,
  required this.challengeConfig, required this.balanceController});

  Future initAsync() async {
    wordInputController.onInputAccepted.subscribe((args) {
      if(isActive)
        timerController.addStep(challengeConfig.wordCompletionTimeRewardSec);
    });
    timerController.timeIsOverEvent.subscribe((args) => handleGameCompletionAsync(args!.value));
  }

  void startGame() {
    timerController.start(challengeConfig.totalTimeSec,
        challengeConfig.wordCompletionTimeRewardSec);
    isActive = true;
  }

  void pauseGame() {
    isActive = false;
    timerController.pause();
  }

  void resumeGame() {
    isActive = true;
    timerController.resume();
  }

  void terminateGame(){
    isActive = false;
    timerController.stop();
    wordInputController.reset();
  }

  Future handleGameCompletionAsync(int timeSpent) async{
    print("handleGameCompletion..");
    isActive = false;
    timerController.stop();
    var rewardCoins = wordInputController.completedWordsCount * 5;
    balanceController.addBalanceAsync(rewardCoins);
  }
}
