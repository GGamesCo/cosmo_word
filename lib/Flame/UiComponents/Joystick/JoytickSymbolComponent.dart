import 'package:flutter/services.dart';

import '../../UiComponents/Joystick/DragPointerLocation.dart';
import '../../UiComponents/Joystick/JoystickSymbolSpriteComponent.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:event/event.dart';

class JoystickSymbolComponent extends PositionComponent with Tappable, Draggable{
  int id;
  String symbolId;

  Vector2 cursorPosition = new Vector2(0, 0);
  bool isActive  = false;
  late JoystickSymbolSpriteComponent btn;

  var tapDown = Event<SymbolPointerLocationArgs>();
  var tapUp = Event();
  var draggUpdate = Event<SymbolPointerLocationArgs>();
  var dragEnd = Event<SymbolPointerLocationArgs>();

  JoystickSymbolComponent({required this.id, required this.symbolId});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;

    btn = JoystickSymbolSpriteComponent(this.symbolId);
    btn.size = size;
    btn.anchor = Anchor.center;
    btn.position = size/2;
    add(btn);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
    btn.isActive = isActive;
  }

  @override
  bool onTapDown(TapDownInfo event){
    cursorPosition = wordToLocalPosition(event.eventPosition.game);
    tapDown.broadcast(SymbolPointerLocationArgs(id: id, symbol: symbolId, location: cursorPosition));
    return true;
  }

  @override
  bool onTapUp(TapUpInfo event){
    tapUp.broadcast();
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo event){
    cursorPosition = wordToLocalPosition(event.eventPosition.game);
    draggUpdate.broadcast(SymbolPointerLocationArgs(id: id, symbol: symbolId, location: cursorPosition));
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo event){
    print("Symbol drag end.");
    dragEnd.broadcast(SymbolPointerLocationArgs(id: id, symbol: symbolId, location: event.velocity));
    return false;
  }

  bool isPointInsideSymbol(Vector2 point){
    return point.x >= (position + transform.offset).x && point.y >= (position + transform.offset).y
        && point.x <= (position + transform.offset + size).x && point.y <=  (position + transform.offset + size).y;
  }

  Future<void> changeStateAnimated(bool toogle) async {
      if (isActive == toogle){
        return;
      }

      isActive = toogle;

      double scaleFactor = 1;
      while(scaleFactor > 0.8){
        scaleFactor -= 0.02;
        await Future.delayed(const Duration(milliseconds: 10));
        btn.scale = Vector2(scaleFactor, scaleFactor);
      }

      while(scaleFactor < 1){
        scaleFactor += 0.02;
        await Future.delayed(const Duration(milliseconds: 10));
        btn.scale = Vector2(scaleFactor, scaleFactor);
      }

      btn.scale = Vector2(1, 1);
  }

  Vector2 wordToLocalPosition(Vector2 positionInGame){
    var parentComponent = (parent as PositionComponent);
    var parentPosition = parentComponent.position + parentComponent.transform.offset;
    var localEventPosition = positionInGame - parentPosition;

    cursorPosition = Vector2(localEventPosition.x > 0 ? localEventPosition.x : 0, localEventPosition.y > 0 ? localEventPosition.y : 0);
    return cursorPosition;
  }
}