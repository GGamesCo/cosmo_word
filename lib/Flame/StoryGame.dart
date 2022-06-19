import 'dart:math';
import 'package:cosmo_word/GameBL/Story/StoryStateController.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeAtackStage.dart';
import 'package:cosmo_word/Flame/ElementsLayoutBuilder.dart';
import 'package:cosmo_word/Flame/Models/GameUiElement.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/Abstract/InputDisplayController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StoryLevel/LevelProgressBarController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/GameTypes.dart';

class StoryGame extends FlameGame with HasTappables, HasDraggables {

  final StoryStateController storyStateController;

  late GameElementsLayout _layoutData;

  late BackgroundController _backgroundController;
  late InputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late LevelProgressBarController _levelProgressBarController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  StoryGame({required this.storyStateController});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {
    var layoutBuilder = ElementsLayoutBuilder(screenWidth: this.size.x, screenHeight: this.size.y);
    _layoutData = layoutBuilder.calculateElementsLayout(GameType.StoryGame);

    await FlameAudio.audioCache.loadAll([
      'btn-press-1.mp3', 'btn-press-2.mp3', 'btn-press-3.mp3', 'btn-press-4.mp3', 'btn-press-5.mp3', 'fail.mp3', 'fall.mp3', 'success.mp3'
    ]);

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");
    await _backgroundController.initAsync();

    _inputDisplayController = SeparateBricksInputDisplayController(
      previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
      joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
      wordInputController: storyStateController.wordInputController,
      game: this,
      wordSize: 3
    );
    
     await _inputDisplayController.initAsync();

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

    _levelProgressBarController = LevelProgressBarController(
        layoutData: _layoutData.elementsData[GameUiElement.LevelProgressBar]!,
        barState: storyStateController.getLevelProgressBarState()
    );
    await _levelProgressBarController.initAsync();

    storyStateController.wordInputController.onInputAccepted.subscribe((userInput) {
      handleInputCompleted(userInput!.acceptedWord);
    });

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_levelProgressBarController.rootUiControl);

    _levelProgressBarController.rootUiControl.loaded.then((value) {
      _levelProgressBarController.setProgress(storyStateController.getLevelProgressBarState());
    });
  }

  Future<void> handleInputCompleted(String pickedWord) async {
    var pickedColor = _pickRandomListElement(_colorCodes);
    _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
    _levelProgressBarController.setProgress(storyStateController.getLevelProgressBarState());
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }
}