import 'package:cosmo_word/GameBL/Common/Models/GameState.dart';
import 'package:cosmo_word/Screens/GameScreen/GameScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

abstract class IGameStage with Disposable{
  GameStage get state;

  Widget get root;

  Future initAsync();

  void start();

  void pause();

  void resume();

  void terminate();
}