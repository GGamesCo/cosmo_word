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
      WordSetFlowItem(setId: 4, requiredWordsCount: 4),
    ]),
    WordSetFlow(id: 3, title: "Flow for time challenge", sets: [
      WordSetFlowItem(setId: 1, requiredWordsCount: 2),
      WordSetFlowItem(setId: 2, requiredWordsCount: 2),
      WordSetFlowItem(setId: 3, requiredWordsCount: 1),
      WordSetFlowItem(setId: 4, requiredWordsCount: 1),
      WordSetFlowItem(setId: 5, requiredWordsCount: 1),
    ]),
  ];

  @override
  Future<WordSetFlow> getFlowByIdAsync(int flowId) async {
    return flows.firstWhere((element) => element.id == flowId);
  }
}