import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeChallengeResults.dart';
import 'package:event/event.dart';
import 'package:flame/game.dart';
import '../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'Common/Mixins.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/Abstract/InputDisplayController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/RocketGame/RocketZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'ElementsLayoutBuilder.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/Events/GameCompletedEventArgs.dart';
import 'Models/Events/InputCompletedEventArgs.dart';
import 'Models/GameTypes.dart';
import 'Models/GameUiElement.dart';

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection, HasGameCompletedEvent {

  final RocketChallengeConfig challengeConfig;

  late GameElementsLayout _layoutData;
  late BackgroundController _backgroundController;
  late InputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late RocketZoneController _rocketZoneController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  late DartAsync.Timer _challengeCountDown;
  late int _secondsLeft;

  TimeChallengeGame({required this.challengeConfig});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {

    var layoutBuilder = ElementsLayoutBuilder(screenWidth: this.size.x, screenHeight: this.size.y);
    _layoutData = layoutBuilder.calculateElementsLayout(GameType.TimeChallengeGame);

    var userInputReceivedEvent = Event<InputCompletedEventArgs>();

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");
    _inputDisplayController = SeparateBricksInputDisplayController(
        previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
        joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
        userInputReceivedEvent: userInputReceivedEvent
    );

    _completedWordsZoneController = CompletedWordsZoneController(
        layoutData: _layoutData.elementsData[GameUiElement.CompletedWordsZone]!,
        requiredBrickHeight: 40,
        initialScrollOffset: 0,
        fullContainerHeight: 1800,
        containerScrollThreshold: 0.8,
        containerScrollBricksCount: 6,
        brickFallDuration: 1.5,
        scrollAnimDurationSec: 1
    );
    _completedWordsZoneController.init();

    _rocketZoneController = RocketZoneController(
      layoutData: _layoutData.elementsData[GameUiElement.Rocket]!,
      rocketHeightMultiplier: 0.2,
    );
    _rocketZoneController.init();

    _backgroundController.init();
    _inputDisplayController.init();

    userInputReceivedEvent.subscribe((userInput) {
      handleInputCompleted(userInput);
    });


    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_rocketZoneController.rootUiControl);

    // ?? ?? ? hack to wait until rocket inited and fly zone bounds calculated
    _rocketZoneController.uiComponentLoadedFuture.then((value) {
      setupCountdown();
    });
  }

  void setupCountdown() {
    _secondsLeft = challengeConfig.totalTimeSec;
    _rocketZoneController.initRocketPosition(_secondsLeft, challengeConfig.totalTimeSec);
    _challengeCountDown = DartAsync.Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          _secondsLeft--;
          _rocketZoneController.onCountDownUpdated(_secondsLeft, challengeConfig.totalTimeSec);
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
    if (Random().nextBool()){ // If word accepted
      _secondsLeft = min(
          _secondsLeft + challengeConfig.wordCompletionTimeRewardSec,
          challengeConfig.totalTimeSec
      );

      var pickedWord = wordInput!.inputString;
      var pickedColor = _pickRandomListElement(_colorCodes);

      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
      _inputDisplayController.handleInputCompleted(wordInput);
    }
    else{
      _inputDisplayController.handleInputRejected();
    }
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }
}