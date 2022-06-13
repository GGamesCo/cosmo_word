import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:event/event.dart';

abstract class IWordInputController{
  final Event<Value<String>> onInputRejected = Event<Value<String>>();
  final Event<Value<String>> onInputAccepted = Event<Value<String>>();
  final Event<Value<WordSet>> onSetRefreshed = Event<Value<WordSet>>();

  late WordSet? currentWordSet;
  int get completedWordsCount;

  Future initializeAsync(int size);

  Future refreshSetAsync(int size);

  Future<bool> tryAcceptWordAsync(String word);

  void reset();
}