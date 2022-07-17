class StoryLevelModel {
  final int levelId;
  final int flowId;
  final int coinReward;

  StoryLevelModel({
    required this.levelId,
    required this.flowId,
    required this.coinReward
  });

  StoryLevelModel.fromJson(Map<String, dynamic> json)
      : levelId = json['levelId'],
        flowId = json['flowId'],
        coinReward = json['coinReward'];

  Map toJson() => {
    'levelId': levelId,
    'flowId': flowId,
    'coinReward': coinReward,
  };
}