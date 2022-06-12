import 'package:injectable/injectable.dart';

@Injectable()
class RocketChallengeConfig {
  late int totalTimeSec;
  late int wordCompletionTimeRewardSec;
  late int wordSize;

  RocketChallengeConfig(){
    totalTimeSec = 30;
    wordCompletionTimeRewardSec = 5;
    wordSize = 5;
  }
}