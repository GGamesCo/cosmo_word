import 'dart:convert';

class UserStateModel {
  final int currentLevelId;

  UserStateModel({
    required this.currentLevelId,
  });

  UserStateModel.fromJson(Map<String, dynamic> json)
      : currentLevelId = json['currentLevelId'];

  Map<String, dynamic> toJson() => {
    'currentLevelId': currentLevelId,
  };
}