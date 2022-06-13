import 'dart:async';

abstract class IWordRepository{
  Future<WordSet> getSetAsync(int size, List<String> excludeIds);
}

class WordSet
{
  final String id;
  final int size;
  final List<String> chars;
  final List<String> words;

  WordSet({required this.id, required this.size, required this.chars, required this.words});

  WordSet copy(){
    return WordSet(id: id, size: size, chars: List<String>.from(chars), words: List<String>.from(words));
  }
}