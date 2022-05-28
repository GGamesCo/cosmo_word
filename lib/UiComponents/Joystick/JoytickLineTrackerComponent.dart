import 'package:cosmo_word/UiComponents/Joystick/JoytickSymbolComponent.dart';
import 'package:cosmo_word/UiComponents/Joystick/SymbolLocationModel.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas, Offset;
import 'package:tuple/tuple.dart';

class JoystickLineTrackerComponent extends PositionComponent with HasGameRef {
  static Paint _paint = Paint()
    ..color = Colors.yellow
    ..strokeWidth = 5;

  List<SymbolLocationModel> points = <SymbolLocationModel>[];
  Offset lastCursorPoint = Offset.zero;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (points.length >= 2){
      for (var i = 1; i < points.length; i++){
        canvas.drawLine(points[i-1].position, points[i].position, _paint);
      }

      canvas.drawLine(points.last.position, lastCursorPoint, _paint);
    } else if(points.length == 1){
      canvas.drawLine(points.last.position, lastCursorPoint, _paint);
    }
  }

  void updateLastPoint(Offset point){
    if(points.isEmpty)
      throw Exception("No points to update.");

    lastCursorPoint = point;
  }

  void reset(){
    points.clear();
    lastCursorPoint = Offset.zero;
  }
}
