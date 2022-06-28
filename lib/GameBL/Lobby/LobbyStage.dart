import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IGameState.dart';
import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/Screens/LobbyScreen/LobbyScreen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LobbyStage extends IGameStage{
  final SoundsController soundsController;

  var player = AudioPlayer();

  @override
  GameStage get state => GameStage.Lobby;

  @override
  Widget get root => lobbyScreen;

  late LobbyScreen lobbyScreen;

  LobbyStage({required this.soundsController});

  @override
  Future initAsync() async {
    this.lobbyScreen = LobbyScreen();
    return Completer().completeAndReturnFuture();
  }

  @override
  FutureOr onDispose() {
    player.dispose();
  }

  @override
  void pause() {
    player.stop();
  }

  @override
  void resume() {
    player.stop();
  }

  @override
  void start() async {
    // if (player.state != PlayerState.PLAYING){
    //   var uri = await AudioCache().load("audio/"+SoundsController.LOBBY);
    //   player.play(uri.toString(), volume: 0.1);
    // }
  }

  @override
  void terminate() {
    player.stop();
  }
}