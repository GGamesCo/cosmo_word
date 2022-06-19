import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../Common/TopBar/TopBarLayer.dart';
import 'Layers/Gameplay/GameplayLayer.dart';

class GameScreen extends StatelessWidget {

  final GlobalKey gameScreenKey;
  final FlameGame game;

  GameScreen({required this.game, required this.gameScreenKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: gameScreenKey,
      body: Stack(
        children: [
          GameplayLayer(game: game),
          TopBarLayer(
            showBack: true,
            showSettings: false,
            showBalance: true,
          ),
        ],
      )
    );
  }
}