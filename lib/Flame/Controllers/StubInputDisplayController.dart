import 'dart:math';

import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/TimeChallenge/RocketChallengeConfig.dart';
import 'package:cosmo_word/di.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class StubInputDisplayController implements InputDisplayController{
  final FlameGame game;
  final int wordSize;

  late IWordInputController wordInputController;
  late PreviewZoneComponent previewZone;

  WordJoystickComponent? wordJoystickComponent = null;

  @override
  late Component rootUiControl;

  StubInputDisplayController({required this.game, required this.wordSize}){
    wordInputController = getIt.get<IWordInputController>();
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    previewZone.onInputCompleted(wordInput!);
  }

  @override
  Future<void> handleInputRejected() async {
    previewZone.onInputRejected();
  }

  @override
  Future initAsync() async {
    var container = PositionComponent();
    container.size = Vector2(game.size.x, 305);
    container.position = Vector2(0, 450);

    previewZone = PreviewZoneComponent();
    previewZone.position = Vector2(0, 430);

    container.add(previewZone);

    container.position = Vector2(0, 0);

    rootUiControl = container;

    await wordInputController.initializeAsync(wordSize);
    wordInputController.onSetRefreshed.subscribe((args) => initJoystickUi(args!.value));
    wordInputController.onInputAccepted.subscribe((args) => handleInputCompleted(InputCompletedEventArgs(args!.value)));
    wordInputController.onInputRejected.subscribe((args) => handleInputRejected());

    initJoystickUi(wordInputController.currentWordSet!);
  }

  Future handleJoystickEvent(InputCompletedEventArgs args) async {
    await wordInputController.tryAcceptWordAsync(args!.inputString);
  }

  void initJoystickUi(WordSet wordSet){
    var joystick = WordJoystickComponent(
        alph: wordInputController.currentWordSet!.chars,
        sideLength: 200
    );

    joystick.userInputCompletedEvent.subscribe((args) => handleJoystickEvent(args!));

    joystick.symbolInputAddedEvent.subscribe((eventArgs) {
      print("onSymbolAdded: " + eventArgs!.lastInputSymbol);
      previewZone.onSymbolAdded(eventArgs!);
    });

    if (wordJoystickComponent != null){
      wordJoystickComponent!.onDispose();
      wordJoystickComponent!.removeFromParent();
    }
    wordJoystickComponent = joystick;

    rootUiControl.add(wordJoystickComponent!);
  }
}