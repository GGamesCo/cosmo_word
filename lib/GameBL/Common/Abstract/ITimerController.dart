import 'package:event/event.dart';

abstract class ITimerController{
  // Int - amount of sec user played
  final Event<Value<int>> timeIsOverEvent = new Event<Value<int>>();

  // Int - seconds left
  final Event<Value<int>> timerUpdatedEvent = new Event<Value<int>>();

  late int timeLeftSec;

  void start(int challengeTimeSec, int addStepSec);

  // return seconds left
  int stop();

  void pause();

  void resume();

  void addStep(int? addStepSec);
}

class TimerUpdatedEvent extends EventArgs{
    final int secondsLeft;
    final int totalSeconds;

    TimerUpdatedEvent({required this.secondsLeft, required this.totalSeconds});
}