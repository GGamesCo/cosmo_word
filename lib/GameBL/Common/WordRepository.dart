import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IWordRepository)
class WordRepository implements IWordRepository {

  List<WordSet> sets = [
    WordSet(id: 1, words: ["ADS", "SAD"]),
    WordSet(id: 2, words: ["CARE", "CAR", "RACE", "EAR", "ERA"]),
    WordSet(id: 3, words: ["CLOUD", "LOUD", "COLD", "DOC"]),
    WordSet(id: 4, words: ["THUMB", "BUT", "HUM", "BUM", "HUB", "TUB", "HUT"]),
    WordSet(id: 5, words: ["SIGHT", "HIS", "SIT", "HIT", "HITS", "TUB", "HUT"]),
    WordSet(id: 6, words: ["FLOOD", "FOOD", "FOLD", "FOOL", "OLD"])
  ];

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