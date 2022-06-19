import 'package:injectable/injectable.dart';

import 'StoryLevelModel.dart';

@singleton
class StoryLevelsService {

  final List<StoryLevelModel> levels = [
    StoryLevelModel(levelId: 1, flowId: 2),
    StoryLevelModel(levelId: 2, flowId: 2),
    StoryLevelModel(levelId: 3, flowId: 3),
    StoryLevelModel(levelId: 4, flowId: 4),
  ];

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return levels.firstWhere((element) => element.levelId == levelId);
  }

}