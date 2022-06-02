import 'package:event/event.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../../Flame/WordGame.dart';
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
            height: MediaQuery.of(context).size.height, // ??? ???? magic value. Responsiveness? - REPLACED WITH ACTUAL SCREEN SIZE
            child: GameWidget(game: WordGame(userInputReceivedEvent: userInputEvent))
        ),
        //InputJoystick(userInputEvent: userInputEvent)
      ],
    );
  }
}