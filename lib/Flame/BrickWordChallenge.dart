import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'Controllers/GameScreenController.dart';
import 'Controllers/StubGame/StubChallengeZoneController.dart';
import 'Controllers/StubGame/StubInputDisplayController.dart';
import 'Controllers/StubGame/StubUserInputController.dart';

class BrickWordChallenge extends FlameGame with PanDetector, HasTappables, HasCollisionDetection {
  late Scene wordBrick;

  @override
  Future<void>? onLoad() {
    var gameScreenController = GameScreenController(
        userInputController: StubUserInputController(),
        challengeController: StubChallengeZoneController(),
        inputDisplayController: StubInputDisplayController()
    );
    gameScreenController.init();
    add(gameScreenController.rootUiControl);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    wordBrick.move(info.delta.game);
  }
}