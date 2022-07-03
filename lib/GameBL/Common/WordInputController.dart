import 'dart:async';

import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:event/event.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IFlowRepository.dart';
import 'Abstract/IWordRepository.dart';
import 'Models/InputAcceptedEventArgs.dart';
import 'Models/WordFlowState.dart';

@Injectable(as: IWordInputController)
class WordInputController extends IWordInputController  {

  final IWordRepository wordRepository;
  final IBalanceController balanceController;
  final AnalyticsController analyticsController;

  late WordSetFlow _currentFlow;
  late WordFlowState flowState;

  List<String> _completedWords = List<String>.empty(growable: true);

  WordInputController({
    required this.wordRepository,
    required this.balanceController,
    required this.analyticsController
  });

  @override
  Future initializeAsync(WordSetFlow flow) async {
    _completedWords.clear();
    _currentFlow = flow;
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
    if(currentWordSet.words.contains(word) && !_completedWords.contains(word)){
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

      if(newState.completedWordsInFlow == newState.totalWordsInFlow)
        onFlowCompleted.broadcast();

      analyticsController.logEventAsync(AnalyticEvents.WORD_INPUT, params: {"input": word, "accepted": true});
    } else {
      analyticsController.logEventAsync(AnalyticEvents.WORD_INPUT, params: {"input": word, "accepted": false});
      onInputRejected.broadcast(Value<String>(word));
    }
    return wasWordAccepted;
  }

  WordFlowState _calculateFlowState(){
    var totalWords = _currentFlow.sets.fold(0, (int previousValue, WordSetFlowItem element) => previousValue + element.requiredWordsCount);
    var currentSetId = _currentFlow.sets.first.setId;
    var wordsInSetLeft = 0;

    if(_completedWords.length != totalWords) {
      wordsInSetLeft = _completedWords.length;
      for (final set in _currentFlow.sets) {
        if (wordsInSetLeft < set.requiredWordsCount) {
          currentSetId = set.setId;
          break;
        }

        wordsInSetLeft = wordsInSetLeft - set.requiredWordsCount;
      };
    }
    else{
      currentSetId = _currentFlow.sets.last.setId;
    }

    return WordFlowState(
        flowId: _currentFlow.id,
        setId: currentSetId,
        completedWordsInFlow: _completedWords.length,
        totalWordsInFlow: totalWords,
        wordsInSetLeft: wordsInSetLeft
    );
  }

  Future<String> getHintAsync() async
  {
    var currentWordSet = (await wordRepository.getSetByIdAsync(flowState.setId)).copy();

    var substraction = currentWordSet.words.toSet().difference(_completedWords.toSet());

    if(substraction.isEmpty)
      throw Exception("Can't get a hint from completed word set. Logical error.");

    return substraction.first;
  }

  void reset() {
    _completedWords.clear();
  }

  @override
  FutureOr onDispose() {
    onInputAccepted.unsubscribeAll();
    onInputRejected.unsubscribeAll();
    onSetRefreshed.unsubscribeAll();
  }
}