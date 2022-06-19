import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:event/event.dart';
import 'package:get_it/get_it.dart';

import '../Models/InputAcceptedEventArgs.dart';
import '../Models/WordFlowState.dart';

abstract class IWordInputController with Disposable {
  final Event<Value<String>> onInputRejected = Event<Value<String>>();
  final Event<InputAcceptedEventArgs> onInputAccepted = Event<InputAcceptedEventArgs>();
  final Event onFlowCompleted = Event();
  final Event<Value<WordSet>> onSetRefreshed = Event<Value<WordSet>>();

  late WordFlowState flowState;

  Future initializeAsync(int flowId);

  Future<bool> tryAcceptWordAsync(String word);

  void reset();
}