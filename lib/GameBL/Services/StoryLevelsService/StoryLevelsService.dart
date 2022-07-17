import 'package:cosmo_word/GameBL/Configs/GameConfigController.dart';
import 'package:injectable/injectable.dart';

import 'StoryLevelModel.dart';

@singleton
class StoryLevelsService {
  final GameConfigController _gameConfigController;

  StoryLevelsService(this._gameConfigController);

  Future<StoryLevelModel> getLevelConfigById(int levelId) async {
    return _gameConfigController.gameConfigModel.levels.firstWhere((element) => element.levelId == levelId);
  }
}