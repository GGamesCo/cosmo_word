import 'package:injectable/injectable.dart';

import 'StoryStateModel.dart';

@singleton
class StoryStateService {

  late int currentLevelId = 1;

  Future<StoryStateModel> getStoryState() async{
    return StoryStateModel(
      storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
      currentLevelId: currentLevelId
    );
  }

  Future<StoryStateModel> updateStoryProgress(StoryStateModel newState) async {
    currentLevelId++;
    return StoryStateModel(
        storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
        currentLevelId: currentLevelId
    );
  }
}