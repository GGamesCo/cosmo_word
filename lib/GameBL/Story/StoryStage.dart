import 'dart:async';
import 'package:cosmo_word/Flame/StoryGame.dart';

import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IGameState.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/GameBL/Story/StoryStateController.dart';
import 'package:cosmo_word/Screens/GameScreen/GameScreen.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Services/StoryLevelsService/StoryLevelsService.dart';

class StoryStage extends IGameStage{

  late StoryGame storyGame;

  @override
  GameStage get state => GameStage.Story;

  @override
  Widget get root => GameScreen(game: storyGame, gameScreenKey: GlobalKey());

  @override
  Future initAsync() {
    storyGame = StoryGame(
      storyStateController: getIt.get<StoryStateController>(),
      levelsService: getIt.get<StoryLevelsService>(),
      wordInputController: getIt.get<IWordInputController>()
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