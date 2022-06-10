import 'dart:async';

abstract class IWordRepository{
  Future<WordSet> getSetAsync(int size, WordSet? exclude);
}

class WordSet
{
  final String id;
  final int size;
  final List<String> chars;
  final List<String> words;

  WordSet({required this.id, required this.size, required this.chars, required this.words});
}