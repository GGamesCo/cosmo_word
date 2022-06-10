import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:uuid/uuid.dart';

class WordRepository extends IWordRepository{

  List<WordSet> sets = [
    WordSet(id: Uuid().v1(), size: 3, chars: ["A", "D", "S"], words: ["ADS", "SAD"]),
    WordSet(id: Uuid().v1(), size: 4, chars: ["C", "A", "R", "E"], words: ["CARE", "CAR", "RACE", "EAR", "ERA"]),
    WordSet(id: Uuid().v1(), size: 5, chars: ["C", "L", "O", "U", "D"], words: ["CLOUD", "LOUD", "COLD", "DOC"]),
    WordSet(id: Uuid().v1(), size: 5, chars: ["T", "H", "U", "M", "B"], words: ["THUMB", "BUT", "HUM", "BUM", "HUB", "TUB", "HUT"]),
    WordSet(id: Uuid().v1(), size: 5, chars: ["S", "I", "G", "H", "T"], words: ["SIGHT", "HIS", "SIT", "HIT", "HITS", "TUB", "HUT"]),
    WordSet(id: Uuid().v1(), size: 5, chars: ["F", "D", "L", "O", "O"], words: ["FLOOD", "FOOD", "FOLD", "FOOL", "OLD"])
  ];

  Future<WordSet> getSetAsync(int size, WordSet? exclude) async {
    Completer completerLoadingStub = Completer();
    completerLoadingStub.complete();
    await completerLoadingStub.future;

    return sets.firstWhere((element) => element.size == size && exclude != null ? element.id != exclude.id: true);
  }
}