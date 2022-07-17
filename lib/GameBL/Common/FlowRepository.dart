import 'package:cosmo_word/GameBL/Configs/GameConfigController.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IFlowRepository.dart';

@Injectable(as: IFlowRepository)
class FlowRepository implements IFlowRepository {

  final GameConfigController _gameConfigController;

  FlowRepository(this._gameConfigController);

  @override
  Future<WordSetFlow> getFlowByIdAsync(int flowId) async {
    return _gameConfigController.gameConfigModel.flows.firstWhere((element) => element.id == flowId);
  }
}