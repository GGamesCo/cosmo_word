import 'dart:async';

import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IGameState.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/Screens/LobbyScreen/LobbyScreen.dart';
import 'package:flutter/src/widgets/framework.dart';

class LobbyStage extends IGameStage{
  @override
  GameStage get state => GameStage.Lobby;

  @override
  Widget get root => lobbyScreen;

  late LobbyScreen lobbyScreen;

  @override
  Future initAsync() {
    this.lobbyScreen = LobbyScreen();
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