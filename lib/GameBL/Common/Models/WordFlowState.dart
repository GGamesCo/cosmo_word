class WordFlowState {
  final int flowId;
  final int setId;

  final int completedWordsInFlow;
  final int totalWordsInFlow;

  final int wordsInSetLeft;

  WordFlowState({
    required this.flowId,
    required this.setId,
    required this.completedWordsInFlow,
    required this.totalWordsInFlow,
    required this.wordsInSetLeft,
  });
}