
import 'package:cosmo_word/Flame/Controllers/StubGame/StaticBackgroundController.dart';
import 'package:event/event.dart';
import 'package:flame/game.dart';

import 'Controllers/GameScreenController.dart';
import 'Controllers/StubGame/StubChallengeZoneController.dart';
import 'Controllers/StubGame/StubInputDisplayController.dart';
import 'Models/Events/InputCompletedEventArgs.dart';

class BrickWordChallenge extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection {

  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  BrickWordChallenge({required this.userInputReceivedEvent});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {

    var gameScreenController = GameScreenController(
      backgroundController: StaticBackgroundController(bgImageFile: "green.jpg"),
      challengeController: StubChallengeZoneController(),
      inputDisplayController: StubInputDisplayController()
    );

    userInputReceivedEvent.subscribe((userInput) {
      gameScreenController.onNewWordInput(userInput);
    });

    gameScreenController.init();
    add(gameScreenController.rootUiControl);
  }
}