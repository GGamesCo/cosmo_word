import 'package:injectable/injectable.dart';

import 'StoryLevelModel.dart';

@singleton
class StoryLevelsService {

  final List<StoryLevelModel> levels = [
    StoryLevelModel(levelId: 1, flowId: 1, backgroundFileName: "mountains_day.jpg", coinReward: 100),
    StoryLevelModel(levelId: 2, flowId: 2, backgroundFileName: "beach_with_boat.jpg", coinReward: 200),
    StoryLevelModel(levelId: 3, flowId: 3, backgroundFileName: "jungles.jpg", coinReward: 300),
    StoryLevelModel(levelId: 4, flowId: 4, backgroundFileName: "mountains_day.jpg", coinReward: 400),
  ];

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return levels.firstWhere((element) => element.levelId == levelId);
  }

}