import 'package:event/event.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../../Flame/BrickWordChallenge.dart';
import '../../../../Flame/Models/Events/InputCompletedEventArgs.dart';
import 'InputJoystick.dart';

class GameplayLayer extends StatelessWidget{

  final Event<InputCompletedEventArgs> userInputEvent;

  GameplayLayer({required this.userInputEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 575, // ??? ???? magic value. Responsiveness?
            child: GameWidget(game: BrickWordChallenge(userInputReceivedEvent: userInputEvent))
        ),
        InputJoystick(userInputEvent: userInputEvent)
      ],
    );
  }
}