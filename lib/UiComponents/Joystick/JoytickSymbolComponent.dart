import 'package:cosmo_word/UiComponents/Joystick/DragPointerLocation.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:event/event.dart';

class JoystickSymbolComponent extends PositionComponent with Tappable, Draggable{
  Paint _paint = Paint();

  String symbolId;
  Vector2 cursorPosition = new Vector2(0, 0);
  bool isActive  = false;

  var draggUpdate = Event<SymbolPointerLocation>();
  var dragEnd = Event<SymbolPointerLocation>();

  JoystickSymbolComponent(this.symbolId);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    width = 50;
    height = 50;
    anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
    _paint.color = isActive ? Colors.red : Colors.white;
    canvas.drawRect(size.toRect(), _paint);
  }

  // @override
  // bool onTapDown(TapDownInfo arg){
  //   print("Global tap position: "+ arg.raw.globalPosition.toString());
  //   print("Local tap position: "+ arg.raw.localPosition.toString());
  //   return true;
  // }

  // @override
  // bool onDragStart(DragStartInfo event) {
  //   print("Drag start position: "+ event.eventPosition.game.toString());
  //   return false;
  // }

  @override
  bool onDragUpdate(DragUpdateInfo event){
    var parentComponent = (parent as PositionComponent);
    var parentPosition = parentComponent.position + parentComponent.transform.offset;
    var localEventPosition = event.eventPosition.game - parentPosition;

    cursorPosition = Vector2(localEventPosition.x > 0 ? localEventPosition.x : 0, localEventPosition.y > 0 ? localEventPosition.y : 0);
    draggUpdate.broadcast(SymbolPointerLocation(symbolId, cursorPosition));
  //  print("Cursor: " + cursorPosition.toString());
    return true;
  }

  @override
  bool onDragEnd(DragEndInfo event){
    print("Symbol drag end.");
    dragEnd.broadcast(SymbolPointerLocation(symbolId, event.velocity));
    return false;
  }

  bool isPointInsideSymbol(Vector2 point){
    return point.x >= (position + transform.offset).x && point.y >= (position + transform.offset).y
        && point.x <= (position + transform.offset + size).x && point.y <=  (position + transform.offset + size).y;
  }
}