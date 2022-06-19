import 'dart:async';
import 'dart:ui';

import 'package:cosmo_word/Flame/UiComponents/Joystick/JoystickUiConfig.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/di.dart';
import 'package:flame/effects.dart';
import 'package:get_it/get_it.dart';
import '../../ElementsLayoutBuilder.dart';
import '../../Models/Events/SymbolInputAddedEventArgs.dart';
import '../../UiComponents/Joystick/DragPointerLocation.dart';
import '../../UiComponents/Joystick/JoytickSymbolComponent.dart';
import '../../UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import '../../UiComponents/Joystick/JoytickLineTrackerComponent.dart';
import 'package:flutter/material.dart' show Curves, Offset;
import 'package:event/event.dart';
import '../../../../Flame/Models/Events/InputCompletedEventArgs.dart';
import 'dart:math';

class WordJoystickComponent extends SpriteComponent with HasGameRef, Disposable  {

  final ElementLayoutData layoutData;

  late JoystickLineTrackerComponent navigator;
  late List<JoystickSymbolComponent> symbols;
  late IWordInputController wordInputController;

  List<String> alph = List<String>.empty();
  double sideLength = 0;

  final Event<InputCompletedEventArgs> userInputCompletedEvent = Event<InputCompletedEventArgs>();
  final Event<SymbolInputAddedEventArgs> symbolInputAddedEvent = Event<SymbolInputAddedEventArgs>();

  WordJoystickComponent({
    required this.layoutData,
    required List<String> alph
  }){
    assert(alph.length >= 3 && alph.length <= 5);

    this.sideLength = sideLength;
    this.alph = alph;
    this.wordInputController = getIt.get<IWordInputController>();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('widget/joystickBg.png');

    var uiConfig = JoystickUiConfig(layoutData.size.x);
    anchor = layoutData.anchor;
    position = layoutData.position;
    size = layoutData.size;

    navigator = JoystickLineTrackerComponent();
    add(navigator);

    symbols = <JoystickSymbolComponent>[];

    var btnsConfig = uiConfig.configs[alph.length]!;
    for (var i = 0; i < alph.length; i++){
      symbols.add(JoystickSymbolComponent(alph[i])
        ..position = btnsConfig[i].position
        ..size = btnsConfig[i].size);
    }

    for (var symbol in symbols) {
      add(symbol);
      symbol.tapDown + (arg) => {startCollectingWord(arg!)};
      symbol.tapUp + (arg) {
        reset();
        userInputCompletedEvent.broadcast(InputCompletedEventArgs(""));
      };
      symbol.draggUpdate +
          (arg) => {
                if (arg != null) {onDraggUpdate(arg)}
              };

      symbol.dragEnd +
          (arg) => {
                if (arg != null) {onDragEnd(arg)}
              };
    }
  }

  void onDraggUpdate(SymbolPointerLocationArgs arg) {
    if (navigator.isReseting)
      return;

    if (navigator.points.isNotEmpty &&
        navigator.points.first.id != arg.symbolId) {
      reset();
    }

    if (!navigator.points.map((x) => x.id).contains(arg.symbolId)){
      startCollectingWord(arg);
    }

    var lineEndPosition = arg.location;

    // Init current cursor position
    navigator.lastCursorPoint = Offset(lineEndPosition.x, lineEndPosition.y);

    for (var symbol in symbols) {
      if (symbol.isPointInsideSymbol(lineEndPosition)) {
        if (!navigator.points.map((x) => x.id).contains(symbol.symbolId)) {
          navigator.points.add(SymbolLocationModel(symbol.symbolId, Offset(symbol.x, symbol.y)));
          var addedSymbolEvent = SymbolInputAddedEventArgs(lastInputSymbol: symbol.symbolId, inputString: navigator.inputString);
          symbolInputAddedEvent.broadcast(addedSymbolEvent);
          symbol.changeStateAnimated(true);
        }
      }
    }
  }

  void onDragEnd(SymbolPointerLocationArgs arg) {
    if (navigator.points.first.id != arg.symbolId)
      throw Exception(
          "Wrong end event. Expected drag end for symbol ${navigator.points.first.id} but occured for ${arg.symbolId}");

    userInputCompletedEvent.broadcast(InputCompletedEventArgs(navigator.inputString));
    // #Usage: Remove from here and Call outside Reset if Word accepted and ResetAnimated if declined
    reset();

  }

  void startCollectingWord(SymbolPointerLocationArgs arg){
    if (navigator.isReseting)
      return;

    var startSymbolLocation = symbols
        .firstWhere((element) => element.symbolId == arg.symbolId)
        .position
        .toOffset();
    if (!navigator.points.map((x) => x.id).contains(arg.symbolId)) {
      navigator.points
          .add(SymbolLocationModel(arg.symbolId, startSymbolLocation));
      symbols.firstWhere((element) => element.symbolId == arg.symbolId).changeStateAnimated(true);
      var addedSymbolEvent = SymbolInputAddedEventArgs(lastInputSymbol: arg.symbolId, inputString: navigator.inputString);
      symbolInputAddedEvent.broadcast(addedSymbolEvent);
    }

    navigator.lastCursorPoint = Offset(arg.location.x, arg.location.y);
  }

  void resetForcely(){
    navigator.reset();
    symbols.where((element) => element.isActive).forEach((element) {element.changeStateAnimated(false);});
  }

  void shuffle(){
    var rotateEffect = RotateEffect.by(20*pi, EffectController(duration: 0.5));
    var shuffledPositions = shufflePositions(symbols.length);
    add(rotateEffect);

    var oldPositions = symbols.map((x) => Vector2(x.position.x, x.position.y)).toList();
    for (int i = 0; i < symbols.length; i++){
      symbols[i].position = oldPositions[shuffledPositions[i]];
    }
  }

  List<int> shufflePositions(int arrayLength){
    List<int> shuffledPositions = List<int>.empty(growable: true);
    var rnd = Random();
    for(int i = 0; i < arrayLength; i++){
      var newPos = rnd.nextInt(arrayLength);
      while(shuffledPositions.contains(newPos)){
        newPos = rnd.nextInt(arrayLength);
      }

      shuffledPositions.add(newPos);
    }

    return shuffledPositions;
  }

  void reset() {
    navigator.resetAnimated();
    symbols.where((element) => element.isActive).forEach((element) {element.changeStateAnimated(false);});
  }

  @override
  FutureOr onDispose() {
    userInputCompletedEvent.unsubscribeAll();
    symbolInputAddedEvent.unsubscribeAll();
  }
}
