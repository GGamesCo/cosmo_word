import 'dart:convert';

import 'package:cosmo_word/GameBL/Common/Abstract/IFlowRepository.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';

import '../Services/StoryLevelsService/StoryLevelModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GameConfigModel.g.dart';

@JsonSerializable()
class GameConfigModel{
  final int version;
  final List<WordSetFlow> flows;
  final List<StoryLevelModel> levels;
  final List<WordSet> wordSets;

  GameConfigModel(this.version, this.flows, this.levels, this.wordSets);

  factory GameConfigModel.fromJson(Map<String, dynamic> json) => _$GameConfigModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameConfigModelToJson(this);
}