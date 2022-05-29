import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:flutter/painting.dart';

class JoystickSymbolSpriteComponent extends PositionComponent {
  Paint paint = Paint();
  bool isActive  = false;
  String symbolId;

  JoystickSymbolSpriteComponent(this.symbolId);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    width = 40;
    height = 40;
    anchor = Anchor.center;
    position = (parent as PositionComponent).size/2;

    var textComponent = TextComponent()
      ..text = symbolId
      ..textRenderer = TextPaint(style: TextStyle(color: Colors.black, fontSize: 32));

    add(textComponent);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint);
  }
}