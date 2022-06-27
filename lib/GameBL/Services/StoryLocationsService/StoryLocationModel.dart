class StoryLocationModel {
  final int id;
  final List<int> levels;
  final String backgroundFileName;
  final String title;
  final int coinReward;

  StoryLocationModel({
    required this.id,
    required this.levels,
    required this.backgroundFileName,
    required this.title,
    required this.coinReward
  });
}