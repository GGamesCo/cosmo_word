import 'package:injectable/injectable.dart';

import 'UserStateModel.dart';

@singleton
class UserStateService {

  late int currentLevelId = 1;

  Future<UserStateModel> getStoryState() async {
    return UserStateModel(
      storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
      currentLevelId: currentLevelId
    );
  }

  Future<UserStateModel> updateStoryProgress(UserStateModel newState) async {
    currentLevelId++;
    return UserStateModel(
        storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
        currentLevelId: currentLevelId
    );
  }
}