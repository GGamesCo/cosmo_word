import 'dart:math';
import 'package:cosmo_word/Flame/ElementsLayoutBuilder.dart';
import 'package:cosmo_word/Flame/Models/GameUiElement.dart';
import 'package:event/event.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import '../GameBL/Story/StoryLevelConfig.dart';
import 'Common/Mixins.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/Abstract/InputDisplayController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StoryLevel/LevelProgressBarController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/Events/InputCompletedEventArgs.dart';
import 'Models/GameTypes.dart';

class StoryGame extends FlameGame with HasTappables, HasDraggables, HasGameCompletedEvent {

  final StoryLevelConfig storyLevelConfig;

  late GameElementsLayout _layoutData;

  late BackgroundController _backgroundController;
  late InputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late LevelProgressBarController _levelProgressBarController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  late int _completedWordsCount = 0;

  StoryGame({required this.storyLevelConfig});

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

    var userInputReceivedEvent = Event<InputCompletedEventArgs>();

    _backgroundController = StaticBackgroundController(bgImageFile: "green.jpg");
    _backgroundController.init();

    _inputDisplayController = SeparateBricksInputDisplayController(
      previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
      joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
      userInputReceivedEvent: userInputReceivedEvent,
      game: this
    );
    _inputDisplayController.init();

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

    _levelProgressBarController = LevelProgressBarController(
        layoutData: _layoutData.elementsData[GameUiElement.LevelProgressBar]!,
        levelConfig: storyLevelConfig
    );
    _levelProgressBarController.init();

    userInputReceivedEvent.subscribe((userInput) {
      handleInputCompleted(userInput);
    });

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_levelProgressBarController.rootUiControl);
  }

  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    if (Random().nextBool()){ // If word accepted
      var pickedWord = wordInput!.inputString;
      var pickedColor = _pickRandomListElement(_colorCodes);
      _completedWordsCount++;

      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
      _inputDisplayController.handleInputCompleted(wordInput);
      _levelProgressBarController.setProgress(_completedWordsCount/storyLevelConfig.totalWords);    }
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