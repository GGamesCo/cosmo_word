
import 'dart:math';

import 'package:cosmo_word/Flame/Controllers/CompletedWordsZoneController.dart';
import 'package:cosmo_word/Flame/Models/CompletedBrickData.dart';
import 'package:flame/components.dart';

import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/StubGame/StubChallengeZoneUiControl.dart';
import '../Abstract/ChallengeZoneController.dart';

class StubChallengeZoneController implements ChallengeZoneController {

  List<String> _inputWordsList = ['CLOUD', 'DO', 'LOUD', 'DOU', 'COULD' ];
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
      requiredBrickHeight: 20,
      initialScrollOffset: 0,
      fullContainerHeight: 800,
      containerScrollThreshold: 0.6,
      containerScrollStepSize: 0.2,
      scrollAnimDurationSec: 1.5
    );
    _completedWordsZoneController.init();
    rootUiControl.add(_completedWordsZoneController.rootUiControl);
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var pickedWord = _pickRandomListElement(_inputWordsList);
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