import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:event/event.dart';
import 'package:flame/game.dart';

import '../Abstract/Models/RocketChallengeConfig.dart';
import 'Controllers/GameScreenController.dart';
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

  late GameScreenController _gameScreenController;
  late RocketChallengeZoneController _rocketChallengeZoneController;
  late DartAsync.Timer _challengeCountDown;
  late int _secondsLeft;

  TimeChallengeGame({required this.challengeConfig});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {

    var userInputReceivedEvent = Event<InputCompletedEventArgs>();

    _rocketChallengeZoneController = RocketChallengeZoneController();
    _gameScreenController = GameScreenController(
      backgroundController: StaticBackgroundController(bgImageFile: "green.jpg"),
      challengeController: _rocketChallengeZoneController,
      inputDisplayController: StubInputDisplayController(userInputReceivedEvent: userInputReceivedEvent),
    );

    userInputReceivedEvent.subscribe((userInput) {
      handleInputCompleted(userInput);
    });

    _gameScreenController.init();
    add(_gameScreenController.rootUiControl);

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
            gameCompletedEvent.broadcast(TimeChallengeGameCompletedEventArgs(completedWordsCount: 10));
            return;
          }
        }
    );
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    _secondsLeft = min(
        _secondsLeft + challengeConfig.wordCompletionTimeRewardSec,
        challengeConfig.totalTimeSec
    );
    _gameScreenController.onNewWordInput(wordInput);
  }
}