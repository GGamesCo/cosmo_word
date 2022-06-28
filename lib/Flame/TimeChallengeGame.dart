import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
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
import 'Controllers/InputWordParticlesController.dart';
import 'Controllers/RocketGame/RocketZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'ElementsLayoutBuilder.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/GameTypes.dart';
import 'Models/GameUiElement.dart';
import 'UiComponents/ResultOverlay/ResultOverlayUiControl.dart';

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection {

  final RocketChallengeConfig challengeConfig;
  final IWordInputController wordInputController;
  final ITimerController timerController;
  final SoundsController soundsController;

  late GameElementsLayout _layoutData;
  late BackgroundController _backgroundController;
  late SeparateBricksInputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late RocketZoneController _rocketZoneController;
  late InputWordParticlesController _inputWordParticlesController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  TimeChallengeGame({required this.challengeConfig, required this.wordInputController,
  required this.timerController, required this.soundsController});

  @override
  Future<void> onLoad() async {
  //  await gameController.initAsync();
    
    var layoutBuilder = ElementsLayoutBuilder(screenWidth: this.size.x, screenHeight: this.size.y);
    _layoutData = layoutBuilder.calculateElementsLayout(GameType.TimeChallengeGame);

    await soundsController.initAsync();

    _backgroundController = StaticBackgroundController(bgImageFile: "cosmo.png");

    _inputDisplayController = SeparateBricksInputDisplayController(
        previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
        joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
        rotateBtnLayoutData: _layoutData.elementsData[GameUiElement.RotateBtn]!,
        hintBtnLayoutData: _layoutData.elementsData[GameUiElement.HintBtn]!,
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

    _inputWordParticlesController = InputWordParticlesController(
        layoutData: _layoutData.elementsData[GameUiElement.InputWordParticles]!,
        directionVector: Vector2(1, -1),
        particlesCount: 15,
        particleSize: Vector2(20, 20),
        durationSec: 1,
        wordAxisDistributionFactor: 100
    );
    await _inputWordParticlesController.initAsync();

    await _backgroundController.initAsync();
    await _inputDisplayController.initAsync();

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_inputWordParticlesController.rootUiControl);
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
    wordInputController.onInputRejected.subscribe(handleInputRejected);
    timerController.timerUpdatedEvent.subscribe(onTimerUpdated);
    _inputDisplayController.requestPauseGame.subscribe(onRequestPauseGame);
    _inputDisplayController.requestResumeGame.subscribe(onRequestResumeGame);
  }

  void unsubscribeAll(){
    wordInputController.onInputAccepted.unsubscribe(handleInputAccepted);
    timerController.timerUpdatedEvent.unsubscribe(onTimerUpdated);
    _inputDisplayController.requestPauseGame.unsubscribe(onRequestPauseGame);
    _inputDisplayController.requestResumeGame.unsubscribe(onRequestResumeGame);
  }

  void onTimerUpdated(Value<int>? args) async {
    _rocketZoneController.onCountDownUpdated(timerController.timeLeftSec, challengeConfig.totalTimeSec);
  }

  void handleInputAccepted(InputAcceptedEventArgs? wordInput) async {
      var pickedWord = wordInput!.acceptedWord;
      var pickedColor = _pickRandomListElement(_colorCodes);

      add(ResultOverlayUiControl(isSuccess: true));
      _rocketZoneController.animateNewInput(_completedWordsZoneController.bricksStackHeight);
      _inputWordParticlesController.showParticles(wordInput.acceptedWord.length);
      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
  }

  Future<void> handleInputRejected(Value<String>? input) async {
    add(ResultOverlayUiControl(isSuccess: false));
  }

  void onRequestPauseGame(EventArgs? _){
    timerController.pause();
  }

  void onRequestResumeGame(EventArgs? _){
    timerController.resume();
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