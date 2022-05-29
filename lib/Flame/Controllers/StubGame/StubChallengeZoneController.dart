
import 'dart:math';

import 'package:flame/components.dart';

import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/StubGame/StubChallengeZoneUiControl.dart';
import '../Abstract/ChallengeZoneController.dart';
import 'SimpleAnimatedBrick.dart';

class StubChallengeZoneController implements ChallengeZoneController {

  List<String> _inputWordsList = ['CLOUD', 'DO', 'LOUD', 'DOU', 'COULD' ];
  List<String> _colorCodes = ['y', 'g', 'r'];

  Random _random = new Random();

  int _currentBrickPriority = 1000;

  @override
  late Component rootUiControl;

  StubChallengeZoneController(){
    rootUiControl = StubChallengeZoneUiControl(size: Vector2(400, 500), position: Vector2(0,0));
  }

  @override
  Future<void> init() async {

  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var pickedWord = _pickRandomListElement(_inputWordsList);
    var pickedColor = _pickRandomListElement(_colorCodes);
    var wordController = SimpleAnimatedBrick(word: pickedWord, colorCode: pickedColor);
    wordController.init();
    wordController.uiElement.priority = _currentBrickPriority--;
    rootUiControl.add(wordController.uiElement);
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