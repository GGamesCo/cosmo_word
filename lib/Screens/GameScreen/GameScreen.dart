import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../Flame/Common/Mixins.dart';
import '../../Flame/Models/Events/GameCompletedEventArgs.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../Common/TopBar/TopBarLayer.dart';
import 'Layers/Gameplay/GameplayLayer.dart';
import 'Layers/Popups/GameCompletePopup.dart';

class GameScreen extends StatelessWidget {

  final GlobalKey gameScreenKey;
  final FlameGame game;

  GameScreen({required this.game, required this.gameScreenKey}){
    if(game is HasGameCompletedEvent){
      (game as HasGameCompletedEvent).gameCompletedEvent.subscribe(onGameCompleted);
    }
  }

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

  void onGameCompleted(GameCompletedEventArgs? resultsData){
    if(resultsData is TimeChallengeGameCompletedEventArgs){
      showDialog(
        context: gameScreenKey.currentContext!,
        builder: (BuildContext context){
          return GameCompletePopup();
        }
      );
    }
  }


}