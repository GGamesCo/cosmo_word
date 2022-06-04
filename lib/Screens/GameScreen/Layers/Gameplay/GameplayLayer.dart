import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameplayLayer extends StatelessWidget {

  final FlameGame game;

  GameplayLayer({required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height, // ??? ???? magic value. Responsiveness? - REPLACED WITH ACTUAL SCREEN SIZE
            child: GameWidget(game: game)
        ),
        //InputJoystick(userInputEvent: userInputEvent)
      ],
    );
  }
}