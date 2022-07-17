import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/Configs/GameConfigController.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IWordRepository)
class WordRepository implements IWordRepository {

  final GameConfigController _gameConfigController;

  List<WordSet> get sets {
    return _gameConfigController.gameConfigModel.wordSets;
  }

  WordRepository(this._gameConfigController);

  Future<WordSet> getSetAsync(int setSize, List<int> excludeIds) async {
    Completer completerLoadingStub = Completer();
    completerLoadingStub.complete();
    await completerLoadingStub.future;

    return sets.firstWhere((element) => element.size == setSize && !excludeIds.contains(element.id));
  }

  Future<WordSet> getSetByIdAsync(int setId) async {
    return sets.firstWhere((element) => element.id == setId);
  }
}