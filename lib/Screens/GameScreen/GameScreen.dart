import 'package:event/event.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../Flame/Models/Events/GameCompletedEventArgs.dart';
import '../../Flame/Models/Events/InputCompletedEventArgs.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../main.dart';
import 'Layers/Gameplay/GameplayLayer.dart';
import 'Layers/TopBar/TopBarLayer.dart';

class GameScreen extends StatelessWidget {

  late GlobalKey _gameScreenKey;
  final FlameGame game;

  GameScreen({required this.game}){
    _gameScreenKey = GlobalKey();
    if(game is HasGameCompletedEvent){
      (game as HasGameCompletedEvent).gameCompletedEvent.subscribe(onGameCompleted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _gameScreenKey,
      body: Stack(
        children: [
          GameplayLayer(game: game),
          TopBarLayer(),
        ],
      )
    );
  }

  void onGameCompleted(GameCompletedEventArgs? resultsData){
    if(resultsData is TimeChallengeGameCompletedEventArgs){
      showDialog(
          context: _gameScreenKey.currentContext!,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Popup"),
              content: Container(
                child: Text("Completed words: ${resultsData.completedWordsCount}"),
              ),
            );
          }
      );
    }
  }


}