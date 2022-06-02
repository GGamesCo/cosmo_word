
import 'dart:math';

import 'package:cosmo_word/Flame/Controllers/CompletedWordsZoneController.dart';
import 'package:cosmo_word/Flame/Models/CompletedBrickData.dart';
import 'package:cosmo_word/Flame/Models/Configuration/RocketChallengeConfig.dart';
import 'package:flame/components.dart';

import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/Rocket/RocketChallengeZoneUiControl.dart';
import '../Abstract/ChallengeZoneController.dart';
import 'RocketZoneController.dart';

class RocketChallengeZoneController implements ChallengeZoneController {

  List<String> _colorCodes = ['y', 'g', 'r'];

  Random _random = new Random();

  late CompletedWordsZoneController _completedWordsZoneController;
  late RocketZoneController _rocketZoneController;

  @override
  late Component rootUiControl;

  RocketChallengeZoneController(){
    rootUiControl = RocketChallengeZoneUiControl(size: Vector2(400, 430), position: Vector2(0,0));
  }

  @override
  Future<void> init() async {
    _completedWordsZoneController = CompletedWordsZoneController(
      viewportSize: Vector2(280, 430),
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

    _rocketZoneController = RocketZoneController(
        zoneSize: Vector2(100, 400),
        zonePosition: Vector2(281, 30),
        rocketHeight: 70,
        challengeConfig: RocketChallengeConfig(
            totalTimeSec: 180,
            wordCompletionTimeRewardSec: 20
        )
    );
    _rocketZoneController.init();

    rootUiControl.add(_completedWordsZoneController.rootUiControl);
    rootUiControl.add(_rocketZoneController.rootUiControl);
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var pickedWord = wordInput!.inputString;
    var pickedColor = _pickRandomListElement(_colorCodes);

    _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: pickedWord, colorCode: pickedColor));
    _rocketZoneController.handleInputCompleted(wordInput);
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }

  @override
  void onDispose() {

  }
}