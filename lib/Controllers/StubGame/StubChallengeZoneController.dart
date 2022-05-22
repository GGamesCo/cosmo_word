import 'dart:math';
import 'dart:ui';

import 'package:cosmo_word/Controllers/StubGame/SimpleBrickFallAnimationController.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:cosmo_word/Models/Events/InputCompletedEventArgs.dart';

import '../../UiComponents/StubGame/StubChallengeZoneUiControl.dart';
import '../../UiComponents/StubGame/WordSprite.dart';
import '../Abstract/ChallengeZoneController.dart';

class StubChallengeZoneController implements ChallengeZoneController {

  List<String> _inputWordsList = ['CLOUD', 'DO', 'LOUD', 'DOU', 'COULD' ];
  List<String> _colorCodes = ['y', 'g', 'r'];

  Random _random = new Random();

  @override
  late Component rootUiControl;

  StubChallengeZoneController(){
    rootUiControl = StubChallengeZoneUiControl(size: Vector2(400, 500), position: Vector2(0,0));
  }

  @override
  Future<void> init() async {

  }

  @override
  Future<void> onStart() async {
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var pickedWord = _pickRandomListElement(_inputWordsList);
    var pickedColor = _pickRandomListElement(_colorCodes);
    var wordController = SimpleAnimatedBrick(word: pickedWord, colorCode: pickedColor);
    wordController.init();
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