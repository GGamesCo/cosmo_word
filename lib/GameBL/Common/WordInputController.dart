import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IFlowRepository.dart';
import 'Abstract/IWordRepository.dart';
import 'Models/InputAcceptedEventArgs.dart';
import 'Models/WordFlowState.dart';

@Singleton(as: IWordInputController)
class WordInputController extends IWordInputController {

  final IFlowRepository flowRepository;
  final IWordRepository wordRepository;

  late WordSetFlow _currentFlow;
  late WordFlowState flowState;

  List<String> _completedWords = List<String>.empty(growable: true);

  WordInputController({
    required this.flowRepository,
    required this.wordRepository,
  });

  @override
  Future initializeAsync(int flowId) async {
    _currentFlow = await flowRepository.getFlowByIdAsync(flowId);
    flowState = _calculateFlowState();

    var currentWordSet = (await wordRepository.getSetByIdAsync(flowState.setId)).copy();
    onSetRefreshed.broadcast(Value<WordSet>(currentWordSet));
  }

  @override
  Future<bool> tryAcceptWordAsync(String word) async {
    var currentWordSet = (await wordRepository.getSetByIdAsync(flowState.setId)).copy();

    if (currentWordSet.words.isEmpty)
      throw Exception("Word set is empty.");

    bool wasWordAccepted = false;
    if(currentWordSet.words.contains(word)){
      _completedWords.add(word);
      var oldState = flowState;
      var newState = _calculateFlowState();
      flowState = newState;
      wasWordAccepted = true;

      if(oldState.setId != newState.setId){
        var newWordSet = (await wordRepository.getSetByIdAsync(flowState.setId)).copy();
        onSetRefreshed.broadcast(Value<WordSet>(newWordSet));
      }
      onInputAccepted.broadcast(InputAcceptedEventArgs(
        acceptedWord: word,
        flowState: newState
      ));
    }else{
      onInputRejected.broadcast(Value<String>(word));
    }

    return wasWordAccepted;
  }

  WordFlowState _calculateFlowState(){
    var currentSetId = _currentFlow.sets.first.setId;
    var wordsLeft = _completedWords.length;
    for(final set in _currentFlow.sets){
      if(wordsLeft < set.requiredWordsCount) {
        currentSetId = set.setId;
        break;
      }

      wordsLeft = wordsLeft - set.requiredWordsCount;
    };

    var totalWords = _currentFlow.sets.fold(0, (int previousValue, WordSetFlowItem element) => previousValue + element.requiredWordsCount);

    return WordFlowState(
        flowId: _currentFlow.id,
        setId: currentSetId,
        completedWordsInFlow: _completedWords.length,
        totalWordsInFlow: totalWords,
        wordsInSetLeft: wordsLeft
    );
  }

  void reset() {
    _completedWords.clear();
  }
}