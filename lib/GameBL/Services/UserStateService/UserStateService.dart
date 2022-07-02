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

  Future<UserStateModel> setStoryState(UserStateModel newState) async {
    currentLevelId++;
    return UserStateModel(
        storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
        currentLevelId: currentLevelId
    );
  }

  Future<int> getTimeChallengeRecord() async {
    return 1000;
  }

  Future<void> setTimeChallengeRecord(int newRecord) async {

  }
}