import 'dart:async';

abstract class IWordRepository{
  Future<WordSet> getSetAsync(int size, List<int> excludeIds);
  Future<WordSet> getSetByIdAsync(int setId);
}

class WordSet
{
  final int id;
  final List<String> words;

  int get size => words.length;
  List<String> get chars => words.join().split('').toSet().toList();

  WordSet({required this.id, required this.words});

  WordSet copy(){
    return WordSet(id: id, words: List<String>.from(words));
  }
}