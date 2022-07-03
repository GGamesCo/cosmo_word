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
    WordSet(id: 16, chars: ["T", "T", "R", "A", "C"], words: ["TRACT", "CART", "TACT", "TART", "ACT", "CAR", "RAT", "CAT", "TAR", "ART", "ARC"]),
    WordSet(id: 17, chars: ["C", "L", "O", "U", "D"], words: ["CLOUD", "COULD", "LOUD", "COLD", "DOC", "DUO", "COD", "OLD"]),
    WordSet(id: 18, chars: ["B", "L", "A", "N", "D"], words: ["BLAND", "BALD", "BAND", "LAND", "AND", "LAB", "BAD", "NAB", "BAN"]),
    WordSet(id: 19, chars: ["E", "A", "G", "L", "E"], words: ["EAGLE", "GALE", "GLEE", "AGE", "GAL", "ALE", "GEL", "LEG", "LAG"]),
    WordSet(id: 20, chars: ["H", "E", "A", "L", "S"], words: ["HEALS", "LEASH", "HEAL", "SHALE", "HALES", "SALE", "SEAL", "SHEA", "LASH", "SHE", "SEA", "SHA", "ASH", "LEA", "HAS", "ALE"]),
    WordSet(id: 21, chars: ["S", "C", "U", "B", "A"], words: ["SCUBA", "CUBS", "CABS", "BUS", "BAS", "ABS", "SUB", "CUB", "CAB"]),
    WordSet(id: 22, chars: ["A", "F", "T", "S", "F"], words: ["STAFF", "FAST", "FATS", "SAT", "FAT"]),
    WordSet(id: 23, chars: ["S", "L", "E", "O", "R"], words: ["LOSER", "ROLES", "LORE", "SOLE", "ORES", "ROLE", "ROSE", "SORE", "LOSE", "ORE", "REO", "SEL"]),
    WordSet(id: 24, chars: ["C", "E", "L", "O", "N"], words: ["CLONE", "ONCE", "LONE", "NOEL", "CONE", "ONE", "COL", "CON"]),
    WordSet(id: 25, chars: ["T", "I", "K", "H", "N"], words: ["THINK", "HINT", "KITH", "THIN", "KNIT", "INK", "KIT", "HIT", "KIN", "NIT", "TIN"]),
    WordSet(id: 26, chars: ["N", "I", "L", "D", "B"], words: ["BLIND", "BIND", "BID", "BIN", "LID"]),
    WordSet(id: 27, chars: ["P", "A", "S", "K", "E"], words: ["PEAKS", "PEAK", "SPAKE", "SPEAK", "PEAS", "APSE", "APES", "SAKE", "SEA", "SPA", "PEA", "APE", "ASK", "SAP"]),
    WordSet(id: 28, chars: ["S", "L", "O", "I", "D"], words: ["SOLID", "IDOLS", "IDOL", "LIDS", "SLID", "SOLD", "OILS", "SILO", "SOIL", "LID", "OLD", "OIL"]),
    WordSet(id: 29, chars: ["W", "A", "L", "C", "R"], words: ["CRAWL", "CLAW", "CRAW", "CAR", "CAW", "LAW", "RAW", "WAR", "ARC"]),
    WordSet(id: 30, chars: ["O", "N", "A", "I", "P"], words: ["PIANO", "PAIN", "NAP", "PAN", "PIN", "ION", "NIP"]),
    WordSet(id: 31, chars: ["O", "D", "A", "E", "R"], words: ["ADORE", "DARE", "DEAR", "REDO", "READ", "RODE", "ROAD", "EAR", "ERA", "DOE", "RED", "ORE", "ADO", "ARE", "OAR", "ROD"]),
    WordSet(id: 32, chars: ["Y", "R", "R", "S", "O"], words: ["SORRY", "ROSY", "SOY"]),

    WordSet(id: 33, chars: ["C", "A", "R", "E"], words: ["CARE", "CAR", "RACE", "EAR", "ERA"]),
    WordSet(id: 34, chars: ["T", "H", "U", "M", "B"], words: ["THUMB", "BUT", "HUM", "BUM", "HUB", "TUB", "HUT"]),
    WordSet(id: 35, chars: ["F", "L", "O", "O", "D"], words: ["FLOOD", "FOOD", "FOLD", "FOOL", "OLD"]),
    WordSet(id: 36, chars: ["S", "T", "O", "V", "E"], words: ["STOVE", "VOTES", "TOES", "VEST", "VETO", "VETS", "VOES", "VOTE" ]),

    //samopal
    WordSet(id: 37, chars: ["D", "A", "T", "E", "D"], words: ["DATED", "DATE", "DEAD", "ADD", "ATE", "DAD", "EAT", "ETA", "TEA", "TED", "AD", "AT", "TAE", "TAD" ]),
    WordSet(id: 38, chars: ["F", "R", "E", "S", "H"], words: ["FRESH", "HERS", "REFS", "RESH", "SERF", "FER", "FES", "REF", "RES", "SER", "SHE", "HE" ]),
    WordSet(id: 39, chars: ["R", "O", "P", "E"], words: ["ROPE", "PORE", "REPO", "ORE", "PER", "PRO", "REP", "ROE", "OR" ]),
    WordSet(id: 40, chars: ["T", "R", "I", "E", "D"], words: ["TRIED", "TIRED", "DIET", "DIRE", "DIRT", "DITE", "EDIT", "RIDE", "RITE", "TIDE", "TIED", "TIER", "TIRE", "DIE", "RED", "RID", "TED", "TIE", "DIT", "IRE", "IT" ]),
    WordSet(id: 41, chars: ["W", "H", "I", "T", "E"], words: ["WHITE", "WITH", "WHET", "WIT", "WET", "TIE", "THE", "HIT", "HEW", "HET", "WE", "IT", "HI", "HE", "EH"]),
    WordSet(id: 42, chars: ["S", "T", "O", "O", "D"], words: ["STOOD", "SOOT", "DOTS", "TOO", "SOT", "SOD", "DOT", "DOS", "TO", "SO", "OS", "DO"]),
    WordSet(id: 43, chars: ["P", "O", "W", "E", "R"], words: ["POWER", "WORE", "ROPE", "REPO", "PROW", "PORE", "OWER", "WOE", "ROW", "ROE", "POW", "PEW", "PER", "OWE", "ORE", "WE", "RE", "PE", "OW", "OR"]),
    WordSet(id: 44, chars: ["A", "L", "I", "V", "E"], words: ["ALIVE", "VILE", "VIAL", "VELA", "VEIL", "VEAL", "VALE", "LIVE", "LAVE", "ILEA", "EVIL", "VIE", "VIA", "LIE", "LEV", "LEA", "ALE", "AIL", "LA", "EL", "AI"]),
    WordSet(id: 45, chars: ["T", "E", "C", "H", "S"], words: ["TECHS", "CHEST", "TECH", "SECT", "ETCH", "THE", "SHE", "SET", "HET", "HES", "HE", "EH"]),
    WordSet(id: 46, chars: ["C", "R", "I", "M", "E"], words: ["CRIME", "RIME", "RICE", "MIRE", "MICE", "ICER", "EMIR", "RIM", "IRE", "ICE", "RE", "MI", "ME", "EM"]),
    WordSet(id: 47, chars: ["E", "M", "P", "T", "Y"], words: ["EMPTY", "TYPE", "YET", "YEP", "PET", "MET", "YE", "PE", "MY", "ME", "EM"]),
    WordSet(id: 48, chars: ["L", "E", "A", "F", "S"], words: ["LEAFS", "FLEAS", "FALSE", "SELF", "SEAL", "SALE", "SAFE", "LEAS", "LEAF", "FLEA", "ALES", "ALEF", "SEA", "LEA", "ELS", "ELF", "EFS", "ALE", "LA", "FA", "EL", "EF", "AS"]),
    WordSet(id: 49, chars: ["M", "E", "A", "N", "T"], words: ["MEANT", "AMENT", "TEAM", "TAME", "NEAT", "NAME", "MEAT", "MEAN", "MATE", "MANE", "ANTE", "AMEN", "TEN", "TEA", "TAN", "TAM", "NET", "MET", "MEN", "MAT", "MAN", "ETA", "EAT", "ATE", "ANT", "TA", "ME", "MA", "EN", "EM", "AT", "AN", "AM"]),
    WordSet(id: 50, chars: ["D", "R", "I", "L", "L"], words: ["DRILL", "RILL", "DILL", "RID", "LID", "ILL", "ID"]),
    WordSet(id: 51, chars: ["F", "O", "U", "N", "D"], words: ["FOUND", "UNDO", "FUND", "FOND", "NOD", "FUN", "DUO", "DON", "UN", "ON", "OF", "NU", "NO", "DO"]),
    WordSet(id: 52, chars: ["Y", "O", "U", "T", "H"], words: ["YOUTH", "THOU", "YOU", "TOY", "THY", "OUT", "HUT", "HOT", "UH", "TO", "OH"]),
    WordSet(id: 53, chars: ["T", "I", "C", "K", "S"], words: ["TICKS", "STICK", "TICS", "TICK", "SKIT", "SICK", "KITS", "TIC", "SKI", "SIT", "SIC", "KIT", "ITS", "ICK", "CIS", "IT", "IS"]),
    WordSet(id: 54, chars: ["T", "A", "B", "L", "E"], words: ["TABLE", "BLEAT", "TEAL", "TALE", "LATE", "BLAT", "BETA", "BELT", "BEAT", "BALE", "ABLE", "ABET", "TEA", "TAB", "LET", "LEA", "LAB", "ETA", "EAT", "BET", "BAT", "ATE", "ALE", "ALB", "TA", "LA", "EL", "BE", "AT", "AB"]),
    WordSet(id: 55, chars: ["L", "E", "A", "F", "S"], words: ["LEAFS", "FLEAS", "FALSE", "SELF", "SEAL", "SALE", "SAFE", "LEAS", "LEAF", "FLEA", "ALES", "ALEF", "SEA", "LEA", "ELS", "ELF", "EFS", "ALE", "LA", "FA", "EL", "EF", "AS"]),
    WordSet(id: 56, chars: ["F", "I", "B", "R", "E"], words: ["FIBRE", "FIBER", "BRIEF", "RIFE", "FIRE", "BRIE", "RIB", "REF", "IRE", "FIR", "FIB", "RE", "IF", "EF", "BE"]),
    WordSet(id: 57, chars: ["M", "A", "G", "I", "C"], words: ["MAGIC", "MICA", "MAGI", "GAM", "CAM", "AIM", "MI", "MA", "AM", "AI", "AG"]),
    WordSet(id: 58, chars: ["G", "L", "E", "A", "N"], words: ["GLEAN", "ANGLE", "ANGEL", "LEAN", "LANE", "GLEN", "GALE", "NAG", "LEG", "LEA", "LAG", "GEL", "GAL", "ALE", "AGE", "LA", "EN", "EL", "AN", "AG"]),
    WordSet(id: 59, chars: ["R", "I", "D", "E"], words: ["DIRE", "IRED", "RIDE", "DIE", "IRE", "RED", "RED", "REI", "RID", "DE", "ED", "ER", "ID", "RE"]),
    WordSet(id: 60, chars: ["S", "H", "O", "R", "E"], words: ["SHORE", "SHOER", "HOSER", "HORSE", "HEROS", "SORE", "SHOE", "ROSE", "ROES", "RHOS", "RESH", "ORES", "HOSE", "HOES", "HOER", "HERS", "HERO", "EROS", "SHE", "ROE", "RHO", "ORS", "ORE", "OHS", "HOE", "HES", "HER", "SO", "RE", "OS", "OR", "OH", "HE", "EH"]),
    WordSet(id: 61, chars: ["T", "R", "A", "M", "S"], words: ["TRAMS", "SMART", "MARTS", "TSAR", "TRAM", "TARS", "TAMS", "STAR", "RATS", "RAMS", "MATS", "MAST", "MART", "MARS", "ARTS", "ARMS", "TAR", "TAM", "SAT", "RAT", "RAM", "MAT", "MAS", "MAR", "ART", "ARS", "ARM", "TA", "MA", "AT", "AS", "AR", "AM"]),
    WordSet(id: 62, chars: ["W", "O", "R", "T", "S"], words: ["WORTS", "WORST", "STROW", "WORT", "TWOS", "TOWS", "STOW", "SORT", "ROWS", "ROTS", "TWO", "TOW", "SOW", "SOT", "ROW", "ROT", "OWS", "ORS", "TO", "SO", "OW", "OS", "OR"]),
    WordSet(id: 63, chars: ["B", "E", "A", "K"], words: ["BEAK", "BAKE", "KEA", "BE", "AB"]),
    WordSet(id: 64, chars: ["B", "E", "A", "M"], words: ["BEAM", "BAM", "ME", "MA", "EM", "BE", "AM", "AB"]),
    WordSet(id: 65, chars: ["S", "T", "A", "Y"], words: ["STAY", "STY", "SAY", "SAT", "AYS", "YA", "TA", "AY", "AT", "AS"]),
    WordSet(id: 66, chars: ["B", "E", "T", "S"], words: ["BETS", "BEST", "SET", "BET", "BE"]),
    WordSet(id: 67, chars: ["M", "A", "G", "E"], words: ["MAGE", "GAME", "GEM", "GAM", "AGE", "ME", "MA", "EM", "AM", "AG"]),
    WordSet(id: 68, chars: ["R", "I", "C", "E"], words: ["RICE", "ICER", "IRE", "ICE", "RE"]),
    WordSet(id: 69, chars: ["E", "X", "I", "T"], words: ["EXIT", "TIE", "XI", "IT", "EX"]),
    WordSet(id: 70, chars: ["R", "A", "M", "S"], words: ["RAMS", "MARS", "ARMS", "RAM", "MAS", "MAR", "ARS", "ARM", "MA", "AS", "AR", "AM"]),
    WordSet(id: 71, chars: ["O", "U", "R"], words: ["OUR", "OR"]),
    WordSet(id: 72, chars: ["H", "A", "D"], words: ["HAD", "HA", "AH", "AD"]),
    WordSet(id: 73, chars: ["M", "U", "G"], words: ["MUG", "GUM", "MU"]),
    WordSet(id: 74, chars: ["T", "A", "B"], words: ["TAB", "BAT", "TA", "AT", "AB"])
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