import 'package:event/event.dart';

abstract class ITimerController{
  // Duration - amount of time left
  final Event<Value<Duration>> timeIsOverEvent = new Event<Value<Duration>>();

  void startGame(int challengeTimeSec, int addStepSec);

  // return seconds left
  int stop();

  void addStep(int? addStepSec);
}