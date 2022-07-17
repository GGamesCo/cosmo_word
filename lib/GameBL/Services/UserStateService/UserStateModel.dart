import 'dart:convert';

class UserStateModel {
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