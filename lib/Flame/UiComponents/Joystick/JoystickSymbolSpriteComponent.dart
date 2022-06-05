import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Paint, Colors, Canvas;
import 'package:flutter/painting.dart';

class JoystickSymbolSpriteComponent extends SpriteComponent with HasGameRef {
  late String symbolId;

  late Sprite inactiveBg;
  late Color inactiveTextColor;
  late Sprite activeBg;
  late Color activeTextColor;

  bool isActive  = false;

  late TextComponent text;

  JoystickSymbolSpriteComponent(String symbolId){
    this.symbolId = symbolId;
    this.inactiveTextColor = Color.fromRGBO(19, 82, 111, 1);
    this.activeTextColor = Color.fromRGBO(213, 124, 3, 1);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    inactiveBg =  await gameRef.loadSprite('widget/inactiveBtnBg.png');
    activeBg =  await gameRef.loadSprite('widget/activeBtnBg.png');
    sprite = inactiveBg;

    text = TextComponent()
      ..text = symbolId
      ..textRenderer = getTextPaint();
    text.anchor = Anchor.center;
    text.position = size/2;

    add(text);
  }

  @override
  void render(Canvas canvas){
    super.render(canvas);

    text.textRenderer = getTextPaint();
    sprite = isActive ? activeBg : inactiveBg;
  }

  TextPaint getTextPaint(){
    return TextPaint(
      style: TextStyle(
        color: isActive ? activeTextColor : inactiveTextColor,
        fontSize: 32.0,
        fontFamily: 'Roboto',
      ),
    );
  }
}