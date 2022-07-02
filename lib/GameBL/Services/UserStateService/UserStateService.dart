import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserStateModel.dart';

@singleton
class UserStateService {

  final SharedPreferences sharedPreferences;

  final String storyStateKey = 'storyState';
  final UserStateModel storyStateDefaultValue = UserStateModel(
      storyLevelsIdList: [1, 2, 3, 4, 5, 6, 7, 8 ,9, 10],
      currentLevelId: 1
  );

  final String timeChallengeRecordKey = 'timeChallengeRecord';
  final int timeChallengeRecordDefaultValue = 0;

  UserStateService({required this.sharedPreferences});

  void init(){
    if(!sharedPreferences.containsKey(storyStateKey)){
      setStoryState(storyStateDefaultValue);
    }

    if(!sharedPreferences.containsKey(timeChallengeRecordKey)){
      setTimeChallengeRecord(timeChallengeRecordDefaultValue);
    }
  }

  Future<UserStateModel> getStoryState() async {
    var cache = sharedPreferences.getString(storyStateKey);
    return UserStateModel.fromJson(json.decode(cache!));
  }

  Future<UserStateModel> setStoryState(UserStateModel newState) async {
    sharedPreferences.setString(storyStateKey, json.encode(newState));
    return newState;
  }

  Future<int> getTimeChallengeRecord() async {
    return sharedPreferences.getInt(timeChallengeRecordKey)!;
  }

  Future<void> setTimeChallengeRecord(int newRecord) async {
    sharedPreferences.setInt(timeChallengeRecordKey, newRecord);
  }
}