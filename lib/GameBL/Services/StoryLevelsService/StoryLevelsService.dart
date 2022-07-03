import 'package:injectable/injectable.dart';

import 'StoryLevelModel.dart';

@singleton
class StoryLevelsService {

  final List<StoryLevelModel> levels = [
    StoryLevelModel(levelId: 1, flowId: 2, coinReward: 100),
    StoryLevelModel(levelId: 2, flowId: 3, coinReward: 110),
    StoryLevelModel(levelId: 3, flowId: 4, coinReward: 120),
    StoryLevelModel(levelId: 4, flowId: 5, coinReward: 150),
    StoryLevelModel(levelId: 5, flowId: 6, coinReward: 170),
    StoryLevelModel(levelId: 6, flowId: 7, coinReward: 180),
    StoryLevelModel(levelId: 7, flowId: 8, coinReward: 190),
    StoryLevelModel(levelId: 8, flowId: 9, coinReward: 200),
    StoryLevelModel(levelId: 9, flowId: 10, coinReward: 250),
    StoryLevelModel(levelId: 10, flowId: 11, coinReward: 270),
    StoryLevelModel(levelId: 11, flowId: 12, coinReward: 290),
    StoryLevelModel(levelId: 12, flowId: 13, coinReward: 300),
  ];

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return levels.firstWhere((element) => element.levelId == levelId);
  }

}