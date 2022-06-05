import 'package:flutter/material.dart';
import '../../Flame/TimeChallengeGame.dart';
import '../../GameBL/TimeChallenge/RocketChallengeConfig.dart';
import '../GameScreen/GameScreen.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Play challenge'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen(
                  gameScreenKey: GlobalKey(),
                  game: TimeChallengeGame(
                    challengeConfig: RocketChallengeConfig(
                      totalTimeSec: 30,
                      wordCompletionTimeRewardSec: 3
                    )
                  )
                )
              ),
            );
          },
        ),
      ),
    );
  }
}