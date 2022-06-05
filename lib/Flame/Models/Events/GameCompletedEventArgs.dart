import 'package:event/event.dart';

import '../../../GameBL/TimeChallenge/TimeChallengeResults.dart';

class GameCompletedEventArgs extends EventArgs {}

class TimeChallengeGameCompletedEventArgs implements GameCompletedEventArgs{
  final TimeChallengeResults results;

  TimeChallengeGameCompletedEventArgs({required this.results});
}