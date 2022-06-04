import 'package:event/event.dart';

class GameCompletedEventArgs extends EventArgs {}

class TimeChallengeGameCompletedEventArgs implements GameCompletedEventArgs{
  final int completedWordsCount;

  TimeChallengeGameCompletedEventArgs({required this.completedWordsCount});
}

class BrickGameCompletedEventArgs implements GameCompletedEventArgs{
  final int completedWordsCount;

  BrickGameCompletedEventArgs({required this.completedWordsCount});
}