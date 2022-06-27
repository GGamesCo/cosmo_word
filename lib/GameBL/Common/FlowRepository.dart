import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IFlowRepository.dart';

@Injectable(as: IFlowRepository)
class FlowRepository implements IFlowRepository {
  List<WordSetFlow> flows = [
    //flow for tutorial
    WordSetFlow(id: 1, title: "Tutorial flow", sets: [
      WordSetFlowItem(setId: 1, requiredWordsCount: 2),
    ]),
    WordSetFlow(id: 2, title: "Level 1 flow", sets: [
      WordSetFlowItem(setId: 2, requiredWordsCount: 2),
      WordSetFlowItem(setId: 3, requiredWordsCount: 2),
      WordSetFlowItem(setId: 4, requiredWordsCount: 2),
    ]),
    WordSetFlow(id: 3, title: "Level 2", sets: [
      WordSetFlowItem(setId: 6, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 4, title: "Level 3", sets: [
      WordSetFlowItem(setId: 7, requiredWordsCount: 4),
      WordSetFlowItem(setId: 8, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 5, title: "Level 4", sets: [
      WordSetFlowItem(setId: 9, requiredWordsCount: 4),
      WordSetFlowItem(setId: 10, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 6, title: "Level 5", sets: [
      WordSetFlowItem(setId: 11, requiredWordsCount: 4),
      WordSetFlowItem(setId: 12, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 7, title: "Level 6", sets: [
      WordSetFlowItem(setId: 13, requiredWordsCount: 4),
      WordSetFlowItem(setId: 14, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 8, title: "Level 7", sets: [
      WordSetFlowItem(setId: 13, requiredWordsCount: 4),
      WordSetFlowItem(setId: 14, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 9, title: "Level 7", sets: [
      WordSetFlowItem(setId: 16, requiredWordsCount: 4),
      WordSetFlowItem(setId: 17, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 10, title: "Level 8", sets: [
      WordSetFlowItem(setId: 18, requiredWordsCount: 4),
      WordSetFlowItem(setId: 19, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 11, title: "Level 9", sets: [
      WordSetFlowItem(setId: 20, requiredWordsCount: 4),
      WordSetFlowItem(setId: 21, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 12, title: "Level 10", sets: [
      WordSetFlowItem(setId: 22, requiredWordsCount: 4),
      WordSetFlowItem(setId: 23, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 13, title: "Level 11", sets: [
      WordSetFlowItem(setId: 24, requiredWordsCount: 5),
      WordSetFlowItem(setId: 25, requiredWordsCount: 5),
    ]),
  ];

  @override
  Future<WordSetFlow> getFlowByIdAsync(int flowId) async {
    return flows.firstWhere((element) => element.id == flowId);
  }
}