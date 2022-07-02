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

  late int _record = 0;

  Future<int> getTimeChallengeRecord() async {
    return _record;
  }

  Future<void> setTimeChallengeRecord(int newRecord) async {
    _record = newRecord;
  }
}