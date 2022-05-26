
import 'package:event/event.dart';
import 'package:flame/game.dart';

import 'Controllers/GameScreenController.dart';
import 'Controllers/StubGame/StubChallengeZoneController.dart';
import 'Controllers/StubGame/StubInputDisplayController.dart';
import 'Models/Events/InputCompletedEventArgs.dart';

class BrickWordChallenge extends FlameGame with HasTappables, HasCollisionDetection {

  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  BrickWordChallenge({required this.userInputReceivedEvent});

  @override
  Future<void> onLoad() async {
    var gameScreenController = GameScreenController(
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