import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeGameController.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeChallengeResults.dart';
import 'package:cosmo_word/di.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'Common/Mixins.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/RocketGame/RocketZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StubInputDisplayController.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/Events/GameCompletedEventArgs.dart';
import 'Models/Events/InputCompletedEventArgs.dart';

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection, HasGameCompletedEvent {
  final TimeGameController gameController;

  late BackgroundController _backgroundController;
  late StubInputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late RocketZoneController _rocketZoneController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  TimeChallengeGame({required this.gameController});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {
    await gameController.initAsync();

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");
    _inputDisplayController = StubInputDisplayController(game: this, wordSize: gameController.challengeConfig.wordSize);

    _completedWordsZoneController = CompletedWordsZoneController(
        viewportSize: Vector2(280, 425),
        viewportPosition: Vector2(0, 0),
        requiredBrickHeight: 40,
        initialScrollOffset: 0,
        fullContainerHeight: 1800,
        containerScrollThreshold: 0.8,
        containerScrollBricksCount: 6,
        brickFallDuration: 1.5,
        scrollAnimDurationSec: 1
    );
    await _completedWordsZoneController.initAsync();

    _rocketZoneController = RocketZoneController(
      zoneSize: Vector2(100, 358),
      zonePosition: Vector2(281, 30),
      rocketHeight: 70,
    );
    await _rocketZoneController.initAsync();

    await _backgroundController.initAsync();
    await _inputDisplayController.initAsync();

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_rocketZoneController.rootUiControl);

  //   // ?? ?? ? hack to wait until rocket inited and fly zone bounds calculated
    _rocketZoneController.uiComponentLoadedFuture.then((value) {
      gameController.startGame();
      setupSubscriptions();
      //setupCountdown();
  });
  }

  void setupSubscriptions() {
    gameController.wordInputController.onInputAccepted.subscribe((args) => {
      handleInputAccepted(InputCompletedEventArgs(args!.value))
    });

    _rocketZoneController.initRocketPosition(gameController.timerController.timeLeftSec, gameController.challengeConfig.totalTimeSec);
    gameController.timerController.timerUpdatedEvent.subscribe((args) {
      _rocketZoneController.onCountDownUpdated(gameController.timerController.timeLeftSec, gameController.challengeConfig.totalTimeSec);
    });

    gameController.timerController.timeIsOverEvent.subscribe((args) {
      gameCompletedEvent.broadcast(
          TimeChallengeGameCompletedEventArgs(
              results: TimeChallengeResults(completedWordsCount: 10)
          )
      );
    });
  }

  Future<void> handleInputAccepted(InputCompletedEventArgs? wordInput) async {
      var pickedWord = wordInput!.inputString;
      var pickedColor = _pickRandomListElement(_colorCodes);

      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }
}