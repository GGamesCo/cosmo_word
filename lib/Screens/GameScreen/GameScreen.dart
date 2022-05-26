import 'package:event/event.dart';
import 'package:flutter/material.dart';
import '../../Flame/Models/Events/InputCompletedEventArgs.dart';
import 'Layers/Gameplay/GameplayLayer.dart';
import 'Layers/TopBar/TopBarLayer.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInputEvent = Event<InputCompletedEventArgs>();

    return Scaffold(
      body: Stack(
        children: [
          GameplayLayer(userInputEvent: userInputEvent),
          TopBarLayer()
        ],
      )
    );
  }
}