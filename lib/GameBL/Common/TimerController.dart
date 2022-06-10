import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ITimerController)
class TimerController extends ITimerController{

  late Timer timer;
  late Stopwatch stopwatch;

  late int timeLeftSec;
  late int defaultAddStepSec;

  @override
  void addStep(int? addStepSec) {
   timeLeftSec += addStepSec ?? defaultAddStepSec;
  }

  @override
  void startGame(int challengeTimeSec, int addStepSec) {
    timeLeftSec = challengeTimeSec;
    defaultAddStepSec = addStepSec;

    timer = new Timer.periodic(Duration(seconds: 1), handleTimeTick);
    stopwatch = Stopwatch();
    stopwatch.start();
  }

  @override
  int stop() {
    timer.cancel();
    stopwatch.stop();

    return stopwatch.elapsedMilliseconds ~/ 1000;
  }

  void handleTimeTick(Timer t){
    timeLeftSec--;

    if (timeLeftSec < 0){
      stop();
      timeIsOverEvent.broadcast();
    }
  }
}