import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:flutter/painting.dart';

class JoystickSymbolSpriteComponent extends SpriteComponent with HasGameRef {
 // Paint paint = Paint();
  bool isActive  = false;
  String symbolId;

  late Sprite inactiveBg;
  late Sprite activeBg;

  JoystickSymbolSpriteComponent(this.symbolId);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = (parent as PositionComponent).size;
    anchor = Anchor.center;
    position = (parent as PositionComponent).size/2;

    inactiveBg =  await gameRef.loadSprite('widget/inactiveBtnBg.png');
    activeBg =  await gameRef.loadSprite('widget/activeBtnBg.png');
    sprite = inactiveBg;

    var textComponent = TextComponent()
      ..text = symbolId
      ..textRenderer = TextPaint(style: TextStyle(color: Colors.black, fontSize: 32));

    add(textComponent);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);

    sprite = isActive ? activeBg : inactiveBg;
  //  canvas.drawRect(size.toRect(), paint);
  }
}