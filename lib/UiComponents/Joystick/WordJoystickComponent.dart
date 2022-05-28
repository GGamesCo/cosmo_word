import 'package:cosmo_word/UiComponents/Joystick/DragPointerLocation.dart';
import 'package:cosmo_word/UiComponents/Joystick/JoytickSymbolComponent.dart';
import 'package:cosmo_word/UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import 'package:cosmo_word/UiComponents/Joystick/JoytickLineTrackerComponent.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas, Offset;

class WordJoystickComponent extends SpriteComponent with HasGameRef {
  late JoystickLineTrackerComponent navigator;
  late List<JoystickSymbolComponent> symbols;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    sprite = await gameRef.loadSprite('joystick_bg.jpg');
    position = gameRef.size / 2;

    navigator = JoystickLineTrackerComponent();
    add(navigator);

    symbols = <JoystickSymbolComponent>[];
    symbols.add(JoystickSymbolComponent("A")
      ..position = Vector2(size.x * 0.2, size.y * 0.5));

    symbols.add(JoystickSymbolComponent("B")
      ..position = Vector2(size.x * 0.5, size.y * 0.2));

    symbols.add(JoystickSymbolComponent("С")
      ..position = Vector2(size.x * 0.8, size.y * 0.5));

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

  bool cursorAlreadyLeaveLastSymbol = false;
  String ignoredSymbol = "";

  void onDraggUpdate(SymbolPointerLocation arg) {
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
    }

    var lineStartPosition = symbols
        .firstWhere((element) => element.symbolId == arg.symbolId)
        .position;
    var lineEndPosition = arg.location;

    // Add start symbol location
    if (navigator.points.isEmpty) {
      navigator.points.add(SymbolLocationModel(
          arg.symbolId, Offset(lineStartPosition.x, lineStartPosition.y)));
    }

    // Init current cursor position
    navigator.lastCursorPoint = Offset(lineEndPosition.x, lineEndPosition.y);

    var existIntersections = false;
    for (var symbol in symbols) {
      if (symbol.isPointInsideSymbol(lineEndPosition)) {
        existIntersections = true;
        if (!navigator.points.map((x) => x.id).contains(symbol.symbolId) && symbol.symbolId != ignoredSymbol) {
          navigator.points.add(SymbolLocationModel(symbol.symbolId, Offset(symbol.x, symbol.y)));
          cursorAlreadyLeaveLastSymbol = false;
        }
        else if (navigator.points.last.id == symbol.symbolId){
          if (cursorAlreadyLeaveLastSymbol){
            ignoredSymbol = navigator.points.last.id;
            navigator.points.removeLast();
          }
        }
      }

      // Highlight all selected symbols
      symbol.isActive =
          navigator.points.map((e) => e.id).contains(symbol.symbolId);
    }

    if (!existIntersections){
      cursorAlreadyLeaveLastSymbol = true;
      ignoredSymbol = "";
    }
  }

  void onDragEnd(SymbolPointerLocation arg) {
    if (navigator.points.first.id != arg.symbolId)
      throw Exception(
          "Wrong end event. Expected drag end for symbol ${navigator.points.first.id} but occured for ${arg.symbolId}");

    reset();
  }

  void reset() {
    navigator.reset();
    symbols.forEach((element) => element.isActive = false);

    print("Reset.");
  }
}
