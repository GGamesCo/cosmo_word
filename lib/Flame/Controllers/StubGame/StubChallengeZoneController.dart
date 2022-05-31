
import 'dart:math';

import 'package:cosmo_word/Flame/Controllers/CompletedWordsZoneController.dart';
import 'package:cosmo_word/Flame/Models/CompletedBrickData.dart';
import 'package:flame/components.dart';

import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/StubGame/StubChallengeZoneUiControl.dart';
import '../Abstract/ChallengeZoneController.dart';

class StubChallengeZoneController implements ChallengeZoneController {

  List<String> _colorCodes = ['y', 'g', 'r'];

  Random _random = new Random();

  late CompletedWordsZoneController _completedWordsZoneController;

  @override
  late Component rootUiControl;

  StubChallengeZoneController(){
    rootUiControl = StubChallengeZoneUiControl(size: Vector2(400, 500), position: Vector2(0,0));
  }

  @override
  Future<void> init() async {
    _completedWordsZoneController = CompletedWordsZoneController(
      viewportSize: Vector2(280, 500),
      viewportPosition: Vector2(0, 0),
      requiredBrickHeight: 40,
      initialScrollOffset: 0,
      fullContainerHeight: 1800,
      containerScrollThreshold: 0.8,
      containerScrollBricksCount: 6,
      brickFallDuration: 1.5,
      scrollAnimDurationSec: 1
    );
    _completedWordsZoneController.init();
    rootUiControl.add(_completedWordsZoneController.rootUiControl);
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var pickedWord = wordInput!.inputString;
    var pickedColor = _pickRandomListElement(_colorCodes);
    _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    //list.removeAt(index);
    return element;
  }

  @override
  void onDispose() {

  }
}