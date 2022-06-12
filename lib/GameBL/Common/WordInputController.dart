import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IWordRepository.dart';

@Singleton(as: IWordInputController)
class WordInputController extends IWordInputController{

  final IWordRepository wordRepository;

  late int setSize;
  WordSet? currentWordSet = null;
  List<String> completedWords = List<String>.empty(growable: true);
  int get completedWordsCount => completedWords.length;

  WordInputController({required this.wordRepository}){

  }

  @override
  Future initializeAsync(int size) async {
    this.setSize = size;
    refreshSetAsync(size);
  }

  @override
  Future refreshSetAsync(int size) async {
    currentWordSet = await wordRepository.getSetAsync(size, currentWordSet);
    onSetRefreshed.broadcast(Value<WordSet>(currentWordSet!));
  }

  @override
  Future<bool> tryAcceptWordAsync(String word) async {
    if (currentWordSet == null)
      await refreshSetAsync(setSize);

    if (currentWordSet!.words.isEmpty)
      throw Exception("Word set is empty.");

    bool wasWordAccepted = false;
    if(currentWordSet!.words.contains(word)){
      completedWords.add(word);
      currentWordSet!.words.remove(word);
      onInputAccepted.broadcast(Value<String>(word));

      wasWordAccepted = true;
    }else{
      onInputRejected.broadcast(Value<String>(word));
    }

    if (currentWordSet!.words.isEmpty){
      await refreshSetAsync(setSize);
    }

    return wasWordAccepted;
  }
}