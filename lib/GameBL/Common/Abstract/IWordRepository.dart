import 'dart:async';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'IWordRepository.g.dart';

abstract class IWordRepository{
  List<WordSet> get sets;

  Future<WordSet> getSetAsync(int size, List<int> excludeIds);
  Future<WordSet> getSetByIdAsync(int setId);
}

@JsonSerializable()
class WordSet
{
  final int id;
  final List<String> chars;
  final List<String> words;

  int get size => words.length;

  WordSet({required this.id, required this.chars, required this.words});

  WordSet copy(){
    return WordSet(id: id, chars: List<String>.from(chars), words: List<String>.from(words));
  }

  factory WordSet.fromJson(Map<String, dynamic> json) => _$WordSetFromJson(json);

  Map<String, dynamic> toJson() => _$WordSetToJson(this);
}