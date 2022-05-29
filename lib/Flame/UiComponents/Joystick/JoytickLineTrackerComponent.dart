import '../../UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Paint, Color, Colors, Canvas, Offset;
import 'package:event/event.dart';

class JoystickLineTrackerComponent extends PositionComponent with HasGameRef {
  Paint _paint = Paint()
    ..color = Color.fromRGBO(241, 174, 89, 1)
    ..strokeWidth = 15;

  List<SymbolLocationModel> points = <SymbolLocationModel>[];
  Offset lastCursorPoint = Offset.zero;

  var deactivatingSymbol = Event<Value<String>>();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (points.isEmpty)
      return;

    if (points.length >= 2) {
      for (var i = 1; i < points.length; i++) {
        canvas.drawLine(points[i - 1].position, points[i].position, _paint);
      }
    }
      if(!isReseting)
        canvas.drawLine(points.last.position, lastCursorPoint, _paint);
  }

  void updateLastPoint(Offset point){
    if (points.isEmpty)
      throw Exception("No points to update.");

    lastCursorPoint = point;
  }

  void reset(){
    points.clear();
    lastCursorPoint = Offset.zero;
  }

  bool isReseting = false;
  Future<void> resetAnimated() async{
    if(isReseting)
      return;

    isReseting = true;

    while(points.length > 0){

      deactivatingSymbol.broadcast(Value(points.last.id));

      if (points.length > 1)
      {
        await Future.delayed(const Duration(milliseconds: 1), cutLastPoint);
      }
      else
      {
        points.clear();
      }
    }

    reset();
    isReseting = false;
  }

  // Line formula: (x-x1)/(x2-x1) = (y-y1)/(y2-y1)
  // y = (x-x1)(y2-y1)/(x2-x1) + y1
  void cutLastPoint(){
    var startPos = points[points.length-2].position;
    var endPos = points.last.position;

    double x = 0;
    double y = 0;

    if (endPos.dx > startPos.dx){
      x = endPos.dx - 2;
      if (x < startPos.dx)
        x = startPos.dx;
    } else if (endPos.dx < startPos.dx){
      x = endPos.dx + 2;
      if (x > startPos.dx)
        x = startPos.dx;
    } else if (startPos.dx == endPos.dx){
      x = endPos.dx;
    }

    y = ((x-startPos.dx) / (endPos.dx-startPos.dx)) * (endPos.dy -startPos.dy) + startPos.dy;

    points.last.position = Offset(x, y);

    if (startPos.dx == endPos.dx)
      points.removeLast();
  }
}
