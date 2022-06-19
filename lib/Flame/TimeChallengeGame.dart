import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Models/InputAcceptedEventArgs.dart';
import 'package:cosmo_word/di.dart';
import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import '../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/RocketGame/RocketZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'ElementsLayoutBuilder.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/GameTypes.dart';
import 'Models/GameUiElement.dart';

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection {

  final RocketChallengeConfig challengeConfig;
  final IWordInputController wordInputController;
  final ITimerController timerController;

  late GameElementsLayout _layoutData;
  late BackgroundController _backgroundController;
  late SeparateBricksInputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late RocketZoneController _rocketZoneController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  TimeChallengeGame({required this.challengeConfig, required this.wordInputController,
  required this.timerController});

  @override
  Future<void> onLoad() async {
  //  await gameController.initAsync();
    
    var layoutBuilder = ElementsLayoutBuilder(screenWidth: this.size.x, screenHeight: this.size.y);
    _layoutData = layoutBuilder.calculateElementsLayout(GameType.TimeChallengeGame);

    await FlameAudio.audioCache.loadAll([
      'btn-press-1.mp3', 'btn-press-2.mp3', 'btn-press-3.mp3', 'btn-press-4.mp3', 'btn-press-5.mp3', 'fail.mp3', 'fall.mp3', 'success.mp3'
    ]);

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");

    _inputDisplayController = SeparateBricksInputDisplayController(
        previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
        joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
        wordInputController: wordInputController,
        game: this,
        wordSize: challengeConfig.wordSize
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
    await _completedWordsZoneController.initAsync();

    _rocketZoneController = RocketZoneController(
      layoutData: _layoutData.elementsData[GameUiElement.Rocket]!,
      rocketHeightMultiplier: 0.2,
    );
    await _rocketZoneController.initAsync();

    await _backgroundController.initAsync();
    await _inputDisplayController.initAsync();

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_rocketZoneController.rootUiControl);

    // ?? ?? ? hack to wait until rocket inited and fly zone bounds calculated
    _rocketZoneController.uiComponentLoadedFuture.then((value) {
   //   gameController.start();

      _rocketZoneController.initRocketPosition(timerController.timeLeftSec, challengeConfig.totalTimeSec);
      setupSubscriptions();
      //setupCountdown();
  });
  }

  void setupSubscriptions() {
    wordInputController.onInputAccepted.subscribe(handleInputAccepted);
    timerController.timerUpdatedEvent.subscribe(onTimerUpdated);
  }

  void unsubscribeAll(){
    wordInputController.onInputAccepted.unsubscribe(handleInputAccepted);
    timerController.timerUpdatedEvent.unsubscribe(onTimerUpdated);
  }

  void onTimerUpdated(Value<int>? args){
    _rocketZoneController.onCountDownUpdated(timerController.timeLeftSec, challengeConfig.totalTimeSec);
  }

  void handleInputAccepted(InputAcceptedEventArgs? wordInput) async {
      var pickedWord = wordInput!.acceptedWord;
      var pickedColor = _pickRandomListElement(_colorCodes);

      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }

  void dispose(){
    unsubscribeAll();
  }
}