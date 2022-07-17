import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'IFlowRepository.g.dart';

abstract class IFlowRepository {
  Future<WordSetFlow> getFlowByIdAsync(int flowId);
}

@JsonSerializable()
class WordSetFlowItem {
  final int setId;
  final int requiredWordsCount;

  WordSetFlowItem({required this.setId, required this.requiredWordsCount});

  factory WordSetFlowItem.fromJson(Map<String, dynamic> json) => _$WordSetFlowItemFromJson(json);

  Map<String, dynamic> toJson() => _$WordSetFlowItemToJson(this);
}

@JsonSerializable()
class WordSetFlow {
  final int id;
  final String title;
  final List<WordSetFlowItem> sets;

  WordSetFlow({required this.id, required this.title, required this.sets});

  factory WordSetFlow.fromJson(Map<String, dynamic> json) => _$WordSetFlowFromJson(json);

  Map<String, dynamic> toJson() => _$WordSetFlowToJson(this);
}