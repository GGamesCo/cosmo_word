import 'dart:async';

import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IWordRepository)
class WordRepository implements IWordRepository {

  List<WordSet> get sets => [
    WordSet(id: 1, chars: ["A", "C", "T"], words: ["ACT", "CAT"]),
    WordSet(id: 2, chars: ["W", "O", "N"], words: ["OWN", "NOW", "WON"]),
    WordSet(id: 3, chars: ["A", "R", "E"],  words: ["ARE", "ERA", "EAR"]),
    WordSet(id: 4, chars: ["T", "A", "P"], words: ["TAP", "PAT", "APT"]),
    WordSet(id: 5, chars: ["D", "R", "I", "P"], words: ["DRIP", "RIP", "RID", "DIP"]),
    WordSet(id: 6, chars: ["F", "A", "I", "R"],  words: ["FAIR", "AIR", "FIR", "FAR"]),
    WordSet(id: 7, chars: ["D", "E", "N", "T"],  words: ["DENT", "TEND", "NET", "TEN", "END", "DEN"]),
    WordSet(id: 8, chars: ["P", "A", "R", "K"], words: ["PARK", "RAP", "PAR", "ARK"]),
    WordSet(id: 9, chars: ["U", "N", "T", "O"], words: ["UNTO", "NOT", "NUT", "TON", "OUT"]),
    WordSet(id: 10, chars: ["L", "A", "D", "Y"], words: ["LADY", "LAD", "DAY", "LAY"]),
    WordSet(id: 11, chars: ["B", "E", "T", "A"], words: ["BETA", "BEAT", "BATE", "ABET", "ATE", "BET", "EAT", "TAB", "TEA", "TAE", "ETA"]),
    WordSet(id: 12, chars: ["B", "A", "R", "N"], words: ["BARN", "BRAN", "ARB", "BAN", "BAR", "BRA", "RAN", "NAB"]),
    WordSet(id: 13, chars: ["S", "A", "V", "E", "D"], words: ["SAVED", "SAVE", "VASE", "SAD", "ADS"]),
    WordSet(id: 14, chars: ["L", "O", "V", "E", "D"], words: ["LOVED", "LOVE", "OLD", "LED", "DOLE", "DOE", "DOVE", "ODE"]), // HARD
    WordSet(id: 15, chars: ["S", "I", "G", "H", "T"], words: ["SIGHT", "HIS", "SIT", "HIT", "HITS", "ITS", "SIGH", "THIS"]),
    WordSet(id: 16, chars: ["T", "T", "R", "A", "C"], words: ["TRACT", "CART", "TACT", "TART", "ACT", "CAR", "RAT", "CAT", "TAR", "ART"]),
    WordSet(id: 17, chars: ["C", "L", "O", "U", "D"], words: ["CLOUD", "COULD", "LOUD", "COLD", "DOC", "DUO", "COD"]),
    WordSet(id: 18, chars: ["B", "L", "A", "N", "D"], words: ["BLAND", "BALD", "BAND", "LAND", "AND", "LAB", "BAD", "NAB", "BAN"]),
    WordSet(id: 19, chars: ["E", "A", "G", "L", "E"], words: ["EAGLE", "AGEE", "GALE", "GLEE", "AGE", "GAL", "ALE", "GEL", "LEG", "LAG"]),
    WordSet(id: 20, chars: ["H", "E", "A", "L", "S"], words: ["HEALS", "LEASH", "HEAL", "SHALE", "HALES", "SHEAL", "SALE", "SEAL", "SHEA", "LASH", "SHE", "SEA", "SHA", "ASH", "LEA", "LAH", "HAS", "ALE"]),
    WordSet(id: 21, chars: ["S", "C", "U", "B", "A"], words: ["SCUBA", "CUBS", "CABS", "BUS", "BAS", "ABS", "SUB", "CUB", "CAB"]),

    WordSet(id: 22, chars: ["C", "A", "R", "E"], words: ["CARE", "CAR", "RACE", "EAR", "ERA"]),
    WordSet(id: 23, chars: ["T", "H", "U", "M", "B"], words: ["THUMB", "BUT", "HUM", "BUM", "HUB", "TUB", "HUT"]),
    WordSet(id: 24, chars: ["F", "L", "O", "O", "D"], words: ["FLOOD", "FOOD", "FOLD", "FOOL", "OLD"]),
    WordSet(id: 25, chars: ["S", "T", "O", "V", "E"], words: ["STOVE", "VOTES", "TOES", "VEST", "VETO", "VETS", "VOES", "VOTE" ])
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