import 'package:injectable/injectable.dart';

import 'StoryLevelModel.dart';

@singleton
class StoryLevelsService {

  final List<StoryLevelModel> levels = [
    StoryLevelModel(levelId: 1, flowId: 2, backgroundFileName: "beach_with_boat.jpg", coinReward: 200),
    StoryLevelModel(levelId: 2, flowId: 3, backgroundFileName: "jungles.jpg", coinReward: 300),
    StoryLevelModel(levelId: 3, flowId: 4, backgroundFileName: "mountains_day.jpg", coinReward: 400),
    StoryLevelModel(levelId: 4, flowId: 5, backgroundFileName: "mountains_day.jpg", coinReward: 500),
    StoryLevelModel(levelId: 5, flowId: 6, backgroundFileName: "beach_with_boat.jpg", coinReward: 500),
    StoryLevelModel(levelId: 6, flowId: 7, backgroundFileName: "jungles.jpg", coinReward: 700),
    StoryLevelModel(levelId: 7, flowId: 8, backgroundFileName: "mountains_day.jpg", coinReward: 700),
    StoryLevelModel(levelId: 8, flowId: 9, backgroundFileName: "mountains_day.jpg", coinReward: 700),
    StoryLevelModel(levelId: 9, flowId: 10, backgroundFileName: "beach_with_boat.jpg", coinReward: 700),
    StoryLevelModel(levelId: 10, flowId: 11, backgroundFileName: "jungles.jpg", coinReward: 700),
    StoryLevelModel(levelId: 11, flowId: 12, backgroundFileName: "beach_with_boat.jpg", coinReward: 700),
    StoryLevelModel(levelId: 12, flowId: 13, backgroundFileName: "jungles.jpg", coinReward: 700),
  ];

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return levels.firstWhere((element) => element.levelId == levelId);
  }

}