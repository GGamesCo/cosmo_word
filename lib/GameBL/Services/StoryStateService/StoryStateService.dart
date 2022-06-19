import 'package:injectable/injectable.dart';

import 'StoryStateModel.dart';

@singleton
class StoryStateService {

  Future<StoryStateModel> getStoryState() async{
    return StoryStateModel(
      storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
      currentLevelId: 1
    );
  }

  Future<StoryStateModel> updateStoryProgress(StoryStateModel newState) async {
    return newState;
  }
}