import 'dart:math';

import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../../Utils/FormatUtils.dart';

class RocketBoxUiControl extends RectangleComponent {

  late TextComponent _timerTxt;
  late Vector2 flyBounds;

  RocketBoxUiControl({required size}) : super(size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    setColor(Colors.transparent);

    var timerShadowImage = await Flame.images.load("rocket/timer-bg-shadow.png");
    var timerImage = await Flame.images.load("rocket/timer-bg.png");
    var delimiterTopImage = await Flame.images.load("rocket/fly-delimiter.png");
    var heightIndicatorImage = await Flame.images.load("rocket/height-indicator.png");
    var delimiterBottomImage = await Flame.images.load("rocket/fly-delimiter.png");
    var sawImage = await Flame.images.load("rocket/saw.png");

    var timerShadow = SpriteComponent(sprite: Sprite(timerShadowImage));
    var timer = SpriteComponent(sprite: Sprite(timerImage));
    var delimiterTop = SpriteComponent(sprite: Sprite(delimiterTopImage));
    var heightIndicator = SpriteComponent(sprite: Sprite(heightIndicatorImage));
    var delimiterBottom = SpriteComponent(sprite: Sprite(delimiterBottomImage));
    var saw = SpriteComponent(sprite: Sprite(sawImage));

    var scale = size.x/delimiterTop.width;

    timerShadow.size = Vector2(timerShadow.width*scale, timerShadow.height*scale);
    timer.size = Vector2(timer.width*scale, timer.height*scale);
    delimiterTop.size = Vector2(delimiterTop.width*scale, delimiterTop.height*scale);
    heightIndicator.size = Vector2(heightIndicator.width*scale, heightIndicator.height*scale);
    delimiterBottom.size = Vector2(delimiterBottom.width*scale, delimiterBottom.height*scale);
    saw.size = Vector2(saw.width*scale, saw.height*scale);

    timerShadow.anchor = Anchor.topCenter;
    timerShadow.position = Vector2(size.x/2, 0);

    timer.anchor = Anchor.center;
    timer.position = Vector2(timerShadow.size.x/2, timerShadow.size.y/2);

    timerShadow.add(timer);

    delimiterTop.anchor = Anchor.topCenter;
    delimiterTop.position = Vector2(size.x/2, timerShadow.position.y + timerShadow.height);

    heightIndicator.anchor = Anchor.topRight;
    heightIndicator.position = Vector2(size.x, delimiterTop.position.y + delimiterTop.height);

    delimiterBottom.anchor = Anchor.topCenter;
    delimiterBottom.position = Vector2(size.x/2, heightIndicator.position.y + heightIndicator.height);

    saw.anchor = Anchor(0.5, 0.48);
    saw.position = Vector2(size.x/2, delimiterBottom.position.y + delimiterBottom.height/2);

    var textPaint = TextPaint(
      style: TextStyle(
        color: Color.fromRGBO(35, 97, 114, 1),
        fontSize: timer.height*0.6,
        letterSpacing: 1,
        fontFamily: 'Roboto',
      ),
    );

    _timerTxt = TextComponent(
        text: "-",
        textRenderer: textPaint,
        anchor: Anchor.center,
        position: Vector2(timer.width/2, timer.height/2)
    );

    timer.add(_timerTxt);

    flyBounds = Vector2(
        delimiterTop.position.y+delimiterTop.height,
        delimiterBottom.position.y
    );

    add(timerShadow);
    add(delimiterTop);
    add(heightIndicator);
    add(saw);
    add(delimiterBottom);

    final effect = RotateEffect.to(-pi*2, EffectController(duration: 1, repeatCount: 1000));
    saw.add(effect);
  }

  void updateTimerState(int secondsLeft) {
    _timerTxt.text = intToTimeLeft(secondsLeft);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.clipRect(this.size.toRect());
  }
}