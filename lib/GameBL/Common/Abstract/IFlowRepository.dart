abstract class IFlowRepository {
  Future<WordSetFlow> getFlowByIdAsync(int flowId);
}

class WordSetFlowItem {
  final int setId;
  final int requiredWordsCount;

  WordSetFlowItem({required this.setId, required this.requiredWordsCount});
}

class WordSetFlow {
  final int id;
  final String title;
  final List<WordSetFlowItem> sets;

  WordSetFlow({required this.id, required this.title, required this.sets});
}