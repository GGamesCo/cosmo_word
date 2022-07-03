import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'RocketFlameUiControl.dart';

class RocketUiControl extends RectangleComponent {

  final double requiredHeight;

  late RocketFlameUiControl _flameUiControl;

  late TextComponent _heightTxt;

  RocketUiControl({required this.requiredHeight});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await Flame.images.load("rocket/rocket.png");

    anchor = Anchor.topCenter;
    var scale = requiredHeight/image.size.y;
    size = Vector2(image.size.x*scale, image.size.y*scale);

    var sprite = SpriteComponent(sprite: Sprite(image));
    sprite.size = size;

    var heightBgImage = await Flame.images.load("rocket/height-bg.png");
    var requiredBgHeight = size.y/2.3;
    var heightBgScale = requiredBgHeight/heightBgImage.size.y;
    var heightBg = SpriteComponent(sprite: Sprite(heightBgImage));
    heightBg.size = Vector2(heightBgImage.size.x*heightBgScale, heightBgImage.size.y*heightBgScale);
    heightBg.position = Vector2(-1.1*heightBg.size.x, size.y/2-heightBg.size.y/2);

    var textPaint = TextPaint(
      style: TextStyle(
        color: Color.fromRGBO(35, 97, 114, 1),
        fontSize: heightBg.height*0.55,
        letterSpacing: 1,
        fontFamily: 'Roboto',
      ),
    );

    _heightTxt = TextComponent(
        text: "467m",
        textRenderer: textPaint,
        anchor: Anchor.center,
        position: Vector2(heightBg.width/2, heightBg.height/2)
    );

    heightBg.add(_heightTxt);

    _flameUiControl = RocketFlameUiControl(requiredFlameWidth: size.x*3);
    _flameUiControl.position = Vector2(sprite.size.x/2, requiredHeight*0.75);

    add(_flameUiControl);
    add(heightBg);
    add(sprite);
  }

  void playFlameAnim(){
    _flameUiControl.playFlameAnim();
  }

  void updateTimerState(int secondsLeft) {
    _heightTxt.text = "123m";
  }
}