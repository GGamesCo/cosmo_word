import 'dart:convert';

class UserStateModel {
  int get currentLevelNumber => storyLevelsIdList.indexOf(currentLevelId) + 1;
  int get nextMilestoneTargetLevel => storyLevelsIdList.indexOf(storyLevelsIdList.last) + 1;

  final List<int> storyLevelsIdList;
  final int currentLevelId;

  UserStateModel({
    required this.storyLevelsIdList,
    required this.currentLevelId,
  });

  UserStateModel.fromJson(Map<String, dynamic> json)
      : currentLevelId = json['currentLevelId'],
        storyLevelsIdList = List<int>.from(jsonDecode(json['storyLevelsIdList']).map((levelId)=> levelId));

  Map<String, dynamic> toJson() => {
    'currentLevelId': currentLevelId,
    'storyLevelsIdList': jsonEncode(storyLevelsIdList),
  };
}