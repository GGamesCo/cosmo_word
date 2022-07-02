import 'dart:async';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/Flame/StoryGame.dart';

import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IFlowRepository.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IGameState.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/Screens/GameScreen/GameScreen.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/StoryLevelsService/StoryLevelsService.dart';
import '../Services/StoryLocationsService/StoryLocationsService.dart';

class StoryStage extends IGameStage{

  late StoryGame storyGame;

  @override
  GameStage get state => GameStage.Story;

  @override
  Widget get root => GameScreen(game: storyGame, gameScreenKey: GlobalKey());

  @override
  Future initAsync() {
    storyGame = StoryGame(
      flowRepository: getIt.get<IFlowRepository>(),
      storyStateController: getIt.get<UserStateController>(),
      levelsService: getIt.get<StoryLevelsService>(),
      locationsService: getIt.get<StoryLocationsService>(),
      wordInputController: getIt.get<IWordInputController>(),
      soundsController: getIt.get<SoundsController>()
    );
    return Completer().completeAndReturnFuture();
  }

  @override
  FutureOr onDispose() {
  }

  @override
  void pause() {

  }

  @override
  void resume() {
  }

  @override
  void start() {
  }

  @override
  void terminate() {
  }
}