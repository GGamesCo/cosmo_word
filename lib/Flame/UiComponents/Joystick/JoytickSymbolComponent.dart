import '../../UiComponents/Joystick/DragPointerLocation.dart';
import '../../UiComponents/Joystick/JoystickSymbolSpriteComponent.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:event/event.dart';

class JoystickSymbolComponent extends PositionComponent with Tappable, Draggable{
  String symbolId;

  Vector2 cursorPosition = new Vector2(0, 0);
  bool isActive  = false;
  late JoystickSymbolSpriteComponent btn;

  var draggUpdate = Event<SymbolPointerLocationArgs>();
  var dragEnd = Event<SymbolPointerLocationArgs>();

  JoystickSymbolComponent(this.symbolId);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;

    btn = JoystickSymbolSpriteComponent(this.symbolId);
    add(btn);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
    btn.isActive = isActive;
  }

  @override
  bool onDragUpdate(DragUpdateInfo event){
    var parentComponent = (parent as PositionComponent);
    var parentPosition = parentComponent.position + parentComponent.transform.offset;
    var localEventPosition = event.eventPosition.game - parentPosition;

    cursorPosition = Vector2(localEventPosition.x > 0 ? localEventPosition.x : 0, localEventPosition.y > 0 ? localEventPosition.y : 0);
    draggUpdate.broadcast(SymbolPointerLocationArgs(symbolId, cursorPosition));
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo event){
    print("Symbol drag end.");
    dragEnd.broadcast(SymbolPointerLocationArgs(symbolId, event.velocity));
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

      btn.scale = Vector2(0.8, 0.8);
      await Future.delayed(const Duration(milliseconds: 30), () {
        btn.scale = Vector2(1, 1);
     } );
  }
}