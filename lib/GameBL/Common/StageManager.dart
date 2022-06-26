import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/Lobby/LobbyStage.dart';
import 'package:cosmo_word/GameBL/Story/StoryStage.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/TimeAtackStage.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'Abstract/IGameState.dart';
import 'Models/GameState.dart';

@singleton
class StageManager {
  late IGameStage currentStage = LobbyStage();

  Future navigateToStage(GameStage state, BuildContext flutterBuildContext) async {
    print("Termination game state ${currentStage.state.toString()}).");
    currentStage.terminate();

    print("Switching to game state ${state.toString()}).");
    IGameStage newStage = createGameStage(state);

    print("Init game state ${state.toString()}).");
    await newStage.initAsync();

    print("Terminate game state ${currentStage.state.toString()}).");
    currentStage.terminate();
    currentStage.onDispose();
    currentStage = newStage;

    Navigator.push(
      flutterBuildContext,
        MaterialPageRoute(builder: (context) => currentStage.root
        )
    );

    print("Start game state ${currentStage.state.toString()}).");
    currentStage.start();
  }

  IGameStage createGameStage(GameStage stageMode){
    IGameStage? newStage = null;
    switch(stageMode) {
      case GameStage.Lobby:{
        newStage = LobbyStage();
      }
        break;
      case GameStage.Story:{
        newStage = StoryStage();
      }
        break;
      case GameStage.TimeAtack: {
        newStage = TimeAtackStage(
            wordRepository: getIt.get<IWordRepository>(),
            wordInputController: getIt.get<IWordInputController>(),
            timerController: getIt.get<ITimerController>(),
            challengeConfig: getIt.get<RocketChallengeConfig>(),
            balanceController: getIt.get<IBalanceController>(),
        soundsController: getIt.get<SoundsController>());
      }
      break;
      default: {
        throw Exception("Unsupported game stage: ${stageMode.toString()}");
      }
    }

    return newStage;
  }
}