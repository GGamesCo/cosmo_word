import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeChallengeResults.dart';
import 'package:event/event.dart';
import 'package:flame/game.dart';
import '../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/Abstract/InputDisplayController.dart';
import 'Controllers/RocketGame/RocketChallengeZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StubInputDisplayController.dart';
import 'Models/Events/GameCompletedEventArgs.dart';
import 'Models/Events/InputCompletedEventArgs.dart';

mixin HasGameCompletedEvent on FlameGame {
  final Event<GameCompletedEventArgs> gameCompletedEvent = Event<GameCompletedEventArgs>();
}

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection, HasGameCompletedEvent {

  final RocketChallengeConfig challengeConfig;

  late BackgroundController _backgroundController;
  late RocketChallengeZoneController _rocketChallengeZoneController;
  late InputDisplayController _inputDisplayController;
  late DartAsync.Timer _challengeCountDown;
  late int _secondsLeft;

  TimeChallengeGame({required this.challengeConfig});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {

    var userInputReceivedEvent = Event<InputCompletedEventArgs>();

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");
    _rocketChallengeZoneController = RocketChallengeZoneController();
    _inputDisplayController = StubInputDisplayController(userInputReceivedEvent: userInputReceivedEvent, game: this);

    _backgroundController.init();
    _rocketChallengeZoneController.init();
    _inputDisplayController.init();

    userInputReceivedEvent.subscribe((userInput) {
      handleInputCompleted(userInput);
    });

    add(_backgroundController.rootUiControl);
    add(_rocketChallengeZoneController.rootUiControl);
    add(_inputDisplayController.rootUiControl);

    // ?? ?? ? hack to wait until rocket inited and fly zone bounds calculated
    _rocketChallengeZoneController.uiComponentLoadedFuture.then((value) {
      setupCountdown();
    });
  }

  void setupCountdown() {
    _secondsLeft = challengeConfig.totalTimeSec;
    _rocketChallengeZoneController.initRocketPosition(_secondsLeft, challengeConfig.totalTimeSec);
    _challengeCountDown = DartAsync.Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          _secondsLeft--;
          _rocketChallengeZoneController.onCountDownUpdated(_secondsLeft, challengeConfig.totalTimeSec);
          if(_secondsLeft == 0){
            _challengeCountDown.cancel();
            gameCompletedEvent.broadcast(
                TimeChallengeGameCompletedEventArgs(
                  results: TimeChallengeResults(completedWordsCount: 10)
                )
            );
            return;
          }
        }
    );
  }

  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    _secondsLeft = min(
        _secondsLeft + challengeConfig.wordCompletionTimeRewardSec,
        challengeConfig.totalTimeSec
    );

    if (Random().nextBool()){ // If word accepted
      _rocketChallengeZoneController.handleInputCompleted(wordInput);
      _inputDisplayController.handleInputCompleted(wordInput);
    }
    else{
      _inputDisplayController.handleInputRejected();
    }
  }
}