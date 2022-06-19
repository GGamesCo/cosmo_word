import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ITimerController)
class TimerController extends ITimerController {
  late Timer timer;
  late Stopwatch stopwatch;

  late int challengeTotalTime;
  late int defaultAddStepSec;

  @override
  void addStep(int? addStepSec) {
    var newTime = timeLeftSec + (addStepSec ?? defaultAddStepSec);
    timeLeftSec = newTime < challengeTotalTime ? newTime : challengeTotalTime;
  }

  @override
  void start(int challengeTimeSec, int addStepSec) {
    challengeTotalTime = challengeTimeSec;
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

  @override
  void pause() {
    stopwatch.stop();
    timer.cancel();
  }

  @override
  void resume() {
    timer = new Timer.periodic(Duration(seconds: 1), handleTimeTick);
    stopwatch.start();
  }

  void handleTimeTick(Timer t){
    timeLeftSec = timeLeftSec-1 > 0 ? timeLeftSec-1 : 0;

    timerUpdatedEvent.broadcast(Value<int>(timeLeftSec));

    if (timeLeftSec <= 0){
      var elapsedSec = stop();
      timeIsOverEvent.broadcast(Value<int>(elapsedSec));
    }
  }
}