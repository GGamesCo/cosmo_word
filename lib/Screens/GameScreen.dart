import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../Flame/BrickWordChallenge.dart';
import 'LobbyScreen.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: BrickWordChallenge()),
          Positioned(
            top: 30,
            left: 20,
            child: ElevatedButton(
              child: const Text('<-'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LobbyScreen()),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}