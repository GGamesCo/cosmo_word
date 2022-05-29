import 'package:cosmo_word/Flame/UiComponents/Joystick/JoystickUiConfig.dart';
import '../../UiComponents/Joystick/DragPointerLocation.dart';
import '../../UiComponents/Joystick/JoytickSymbolComponent.dart';
import '../../UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import '../../UiComponents/Joystick/JoytickLineTrackerComponent.dart';
import 'package:flutter/material.dart' show Offset;

class WordJoystickComponent extends SpriteComponent with HasGameRef {
  late JoystickLineTrackerComponent navigator;
  late List<JoystickSymbolComponent> symbols;

  List<String> alph = List<String>.empty();

  WordJoystickComponent({required List<String> alph}){
    assert(alph.length >= 3 && alph.length <= 5);

    this.alph = alph;
}

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('widget/joystickBg.png');


    var uiConfig = JoystickUiConfig();
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - uiConfig.size.y);
    size = Vector2(uiConfig.size.x, uiConfig.size.y);

    navigator = JoystickLineTrackerComponent();
    navigator.deactivatingSymbol + (arg) => {
      symbols.firstWhere((element) => element.symbolId == arg!.value).changeStateAnimated(false)
    };
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

  bool cursorAlreadyLeaveLastSymbol = false;
  String ignoredSymbol = "";

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
          symbol.isActive = true;
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
      //symbol.isActive =
      //    ;
      symbol.changeStateAnimated(navigator.points.map((e) => e.id).contains(symbol.symbolId));
    }

    if (!existIntersections){
      cursorAlreadyLeaveLastSymbol = true;
      ignoredSymbol = "";
    }
  }

  void onDragEnd(SymbolPointerLocationArgs arg) {
    if (navigator.points.first.id != arg.symbolId)
      throw Exception(
          "Wrong end event. Expected drag end for symbol ${navigator.points.first.id} but occured for ${arg.symbolId}");

    // #Usage: Remove from here and Call outside Reset if Word accepted and ResetAnimated if declined
    reset();
  }

  void reset() {
    navigator.resetAnimated();
  //  symbols.forEach((element) => element.isActive = false);

    print("Reset.");
  }
}
