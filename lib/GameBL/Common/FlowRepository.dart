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
    WordSetFlow(id: 2, title: "Level 1", sets: [
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
      WordSetFlowItem(setId: 15, requiredWordsCount: 8),
    ]),
    WordSetFlow(id: 9, title: "Level 8", sets: [
      WordSetFlowItem(setId: 16, requiredWordsCount: 4),
      WordSetFlowItem(setId: 17, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 10, title: "Level 9", sets: [
      WordSetFlowItem(setId: 18, requiredWordsCount: 4),
      WordSetFlowItem(setId: 19, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 11, title: "Level 10", sets: [
      WordSetFlowItem(setId: 20, requiredWordsCount: 4),
      WordSetFlowItem(setId: 21, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 12, title: "Level 11", sets: [
      WordSetFlowItem(setId: 22, requiredWordsCount: 4),
      WordSetFlowItem(setId: 23, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 13, title: "Level 12", sets: [
      WordSetFlowItem(setId: 24, requiredWordsCount: 7),
      WordSetFlowItem(setId: 25, requiredWordsCount: 8),
    ]),
    WordSetFlow(id: 14, title: "Level 13", sets: [
      WordSetFlowItem(setId: 26, requiredWordsCount: 5),
      WordSetFlowItem(setId: 27, requiredWordsCount: 9),
    ]),
    WordSetFlow(id: 15, title: "Level 14", sets: [
      WordSetFlowItem(setId: 28, requiredWordsCount: 8),
      WordSetFlowItem(setId: 29, requiredWordsCount: 8),
    ]),

    //samopal
    WordSetFlow(id: 16, title: "Level 15", sets: [
      WordSetFlowItem(setId: 38, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 17, title: "Level 16", sets: [
      WordSetFlowItem(setId: 37, requiredWordsCount: 5),
      WordSetFlowItem(setId: 39, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 18, title: "Level 17", sets: [
      WordSetFlowItem(setId: 40, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 19, title: "Level 18", sets: [
      WordSetFlowItem(setId: 41, requiredWordsCount: 6),
      WordSetFlowItem(setId: 42, requiredWordsCount: 6),
    ]),
    WordSetFlow(id: 20, title: "Level 19", sets: [
      WordSetFlowItem(setId: 71, requiredWordsCount: 2),
      WordSetFlowItem(setId: 43, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 21, title: "Level 20", sets: [
      WordSetFlowItem(setId: 44, requiredWordsCount: 7),
      WordSetFlowItem(setId: 45, requiredWordsCount: 7),
    ]),
    WordSetFlow(id: 22, title: "Level 21", sets: [
      WordSetFlowItem(setId: 46, requiredWordsCount: 5),
      WordSetFlowItem(setId: 63, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 23, title: "Level 22", sets: [
      WordSetFlowItem(setId: 47, requiredWordsCount: 4),
      WordSetFlowItem(setId: 48, requiredWordsCount: 6),
    ]),
    WordSetFlow(id: 24, title: "Level 23", sets: [
      WordSetFlowItem(setId: 50, requiredWordsCount: 4),
      WordSetFlowItem(setId: 72, requiredWordsCount: 3),
      WordSetFlowItem(setId: 64, requiredWordsCount: 3),
    ]),
    WordSetFlow(id: 25, title: "Level 24", sets: [
      WordSetFlowItem(setId: 51, requiredWordsCount: 5),
      WordSetFlowItem(setId: 52, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 26, title: "Level 25", sets: [
      WordSetFlowItem(setId: 53, requiredWordsCount: 5),
      WordSetFlowItem(setId: 65, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 27, title: "Level 26", sets: [
      WordSetFlowItem(setId: 54, requiredWordsCount: 5),
    ]),
    WordSetFlow(id: 28, title: "Level 27", sets: [
      WordSetFlowItem(setId: 55, requiredWordsCount: 7),
      WordSetFlowItem(setId: 56, requiredWordsCount: 6),
    ]),
    WordSetFlow(id: 29, title: "Level 28", sets: [
      WordSetFlowItem(setId: 57, requiredWordsCount: 5),
      WordSetFlowItem(setId: 66, requiredWordsCount: 4),
      WordSetFlowItem(setId: 67, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 30, title: "Level 29", sets: [
      WordSetFlowItem(setId: 58, requiredWordsCount: 6),
      WordSetFlowItem(setId: 59, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 32, title: "Level 30", sets: [
      WordSetFlowItem(setId: 60, requiredWordsCount: 6),
      WordSetFlowItem(setId: 61, requiredWordsCount: 6),
    ]),
    WordSetFlow(id: 33, title: "Level 31", sets: [
      WordSetFlowItem(setId: 62, requiredWordsCount: 6),
      WordSetFlowItem(setId: 73, requiredWordsCount: 2),
      WordSetFlowItem(setId: 74, requiredWordsCount: 3),
    ]),
    WordSetFlow(id: 34, title: "Level 32", sets: [
      WordSetFlowItem(setId: 68, requiredWordsCount: 3),
      WordSetFlowItem(setId: 69, requiredWordsCount: 3),
      WordSetFlowItem(setId: 70, requiredWordsCount: 5),
    ]),
  ];

  @override
  Future<WordSetFlow> getFlowByIdAsync(int flowId) async {
    return flows.firstWhere((element) => element.id == flowId);
  }
}