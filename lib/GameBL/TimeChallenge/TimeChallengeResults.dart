class TimeChallengeResults {
  final int completedWordsCount;
  final int coinReward;

  final int lastRecord;
  int get reachedHeight => completedWordsCount * 100;

  TimeChallengeResults({required this.completedWordsCount, required this.coinReward, required this.lastRecord});
}