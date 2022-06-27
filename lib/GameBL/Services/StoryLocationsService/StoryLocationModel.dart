class StoryLocationModel {
  final int id;
  final List<int> levels;
  final String backgroundFileName;
  final int coinReward;

  StoryLocationModel({
    required this.id,
    required this.levels,
    required this.backgroundFileName,
    required this.coinReward
  });
}