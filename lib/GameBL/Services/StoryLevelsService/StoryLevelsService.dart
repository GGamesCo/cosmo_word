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
    StoryLevelModel(levelId: 12, flowId: 13, coinReward: 200),
    StoryLevelModel(levelId: 13, flowId: 14, coinReward: 200),
    StoryLevelModel(levelId: 14, flowId: 15, coinReward: 200),

    StoryLevelModel(levelId: 15, flowId: 16, coinReward: 340),
    StoryLevelModel(levelId: 16, flowId: 19, coinReward: 350),
    StoryLevelModel(levelId: 17, flowId: 20, coinReward: 360),
    StoryLevelModel(levelId: 18, flowId: 21, coinReward: 365),
    StoryLevelModel(levelId: 19, flowId: 22, coinReward: 370),
    StoryLevelModel(levelId: 20, flowId: 23, coinReward: 375),
    StoryLevelModel(levelId: 21, flowId: 24, coinReward: 380),
    StoryLevelModel(levelId: 22, flowId: 25, coinReward: 385),
    StoryLevelModel(levelId: 23, flowId: 26, coinReward: 390),
    StoryLevelModel(levelId: 24, flowId: 27, coinReward: 395),
    StoryLevelModel(levelId: 25, flowId: 28, coinReward: 400),
    StoryLevelModel(levelId: 26, flowId: 29, coinReward: 405),
    StoryLevelModel(levelId: 27, flowId: 30, coinReward: 410),
    StoryLevelModel(levelId: 28, flowId: 31, coinReward: 415),
    StoryLevelModel(levelId: 29, flowId: 32, coinReward: 420),
    StoryLevelModel(levelId: 30, flowId: 33, coinReward: 425),
    StoryLevelModel(levelId: 31, flowId: 34, coinReward: 430),

  ];

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return levels.firstWhere((element) => element.levelId == levelId);
  }

}