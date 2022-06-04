import 'package:event/event.dart';
import 'package:flame/game.dart';

import 'Controllers/GameScreenController.dart';
import 'Controllers/RocketGame/RocketChallengeZoneController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StubInputDisplayController.dart';
import 'Models/Events/InputCompletedEventArgs.dart';

class TimeChallengeGame extends FlameGame with HasTappables, HasDraggables, HasCollisionDetection {

  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  TimeChallengeGame({required this.userInputReceivedEvent});

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {

    var gameScreenController = GameScreenController(
      backgroundController: StaticBackgroundController(bgImageFile: "green.jpg"),
      challengeController: RocketChallengeZoneController(),
      inputDisplayController: StubInputDisplayController(userInputReceivedEvent: userInputReceivedEvent),
    );

    userInputReceivedEvent.subscribe((userInput) {
      gameScreenController.onNewWordInput(userInput);
    });

    gameScreenController.init();
    add(gameScreenController.rootUiControl);
  }
}