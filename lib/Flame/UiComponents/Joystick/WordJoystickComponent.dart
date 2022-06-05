import 'dart:ui';

import 'package:cosmo_word/Flame/UiComponents/Joystick/JoystickUiConfig.dart';
import '../../Models/Events/SymbolInputAddedEventArgs.dart';
import '../../UiComponents/Joystick/DragPointerLocation.dart';
import '../../UiComponents/Joystick/JoytickSymbolComponent.dart';
import '../../UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import '../../UiComponents/Joystick/JoytickLineTrackerComponent.dart';
import 'package:flutter/material.dart' show Offset;
import 'package:event/event.dart';
import '../../../../Flame/Models/Events/InputCompletedEventArgs.dart';

class WordJoystickComponent extends SpriteComponent with HasGameRef {
  late JoystickLineTrackerComponent navigator;
  late List<JoystickSymbolComponent> symbols;

  List<String> alph = List<String>.empty();
  double sideLength = 0;

  final Event<InputCompletedEventArgs> userInputCompletedEvent;
  late Event<SymbolInputAddedEventArgs> symbolInputAddedEvent;

  WordJoystickComponent({required List<String> alph, required double sideLength, required this.userInputCompletedEvent}){
    assert(alph.length >= 3 && alph.length <= 5);

    this.sideLength = sideLength;
    this.alph = alph;
    this.symbolInputAddedEvent = Event<SymbolInputAddedEventArgs>();
}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('widget/joystickBg.png');


    var uiConfig = JoystickUiConfig(sideLength);
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - uiConfig.size.y);
    size = Vector2(uiConfig.size.x, uiConfig.size.y);

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
      symbol.draggUpdate +
          (arg) => {
                if (arg != null) {onDraggUpdate(arg!)}
              };

      symbol.dragEnd +
          (arg) => {
                if (arg != null) {onDragEnd(arg!)}
              };
    }
  }

  void onDraggUpdate(SymbolPointerLocationArgs arg) {
    if (navigator.points.isNotEmpty &&
        navigator.points.first.id != arg.symbolId) {
      reset();
    }

    var startSymbolLocation = symbols
        .firstWhere((element) => element.symbolId == arg.symbolId)
        .position
        .toOffset();
    if (!navigator.points.map((x) => x.id).contains(arg.symbolId)) {
      navigator.points
          .add(SymbolLocationModel(arg.symbolId, startSymbolLocation));
      symbols.firstWhere((element) => element.symbolId == arg.symbolId).changeStateAnimated(true);
      var addedSymbolEvent = SymbolInputAddedEventArgs(arg.symbolId, navigator.inputString);
      symbolInputAddedEvent.broadcast(addedSymbolEvent);
    }

    var lineEndPosition = arg.location;

    // Init current cursor position
    navigator.lastCursorPoint = Offset(lineEndPosition.x, lineEndPosition.y);

    for (var symbol in symbols) {
      if (symbol.isPointInsideSymbol(lineEndPosition)) {
        if (!navigator.points.map((x) => x.id).contains(symbol.symbolId)) {
          var addedSymbolEvent = SymbolInputAddedEventArgs(symbol.symbolId, navigator.inputString);
          navigator.points.add(SymbolLocationModel(symbol.symbolId, Offset(symbol.x, symbol.y)));
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

  void reset() {
    navigator.resetAnimated();
    symbols.where((element) => element.isActive).forEach((element) {element.changeStateAnimated(false);});

    print("Reset.");
  }
}
