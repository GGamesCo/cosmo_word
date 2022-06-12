import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

class StoryLevelProgressBarUiControl extends RectangleComponent {

  final double requiredWidth;
  final int levelNumber;

  late double _scale;

  late SpriteComponent _fillerControl;
  late double _fillerFullSize;

  StoryLevelProgressBarUiControl({required this.requiredWidth, required this.levelNumber});

  void setProgress(double p){

    final effect = SizeEffect.to(
        Vector2(_fillerControl.size.x, _fillerFullSize*p),
        EffectController(
          duration: 1,
          curve: Curves.easeIn
        )
    );

    _fillerControl.add(effect);
  }

  @override
  Future<void> onLoad() async {
    var backTop = await Flame.images.load("level_progress_bar/back-top.png");
    var backMiddle = await Flame.images.load("level_progress_bar/back-middle.png");
    var backBottom = await Flame.images.load("level_progress_bar/back-bottom.png");

    var barTop = await Flame.images.load("level_progress_bar/bar-top.png");
    var barMiddle = await Flame.images.load("level_progress_bar/bar-middle.png");
    var barBottom = await Flame.images.load("level_progress_bar/bar-bottom.png");

    var filler = await Flame.images.load("level_progress_bar/filler.png");

    _scale = requiredWidth/barMiddle.width;

    var backTopSprite = SpriteComponent(sprite: Sprite(backTop));
    var backMiddleSprite = SpriteComponent(sprite: Sprite(backMiddle));
    var backBottomSprite = SpriteComponent(sprite: Sprite(backBottom));

    var barTopSprite = SpriteComponent(sprite: Sprite(barTop));
    var barMiddleSprite = SpriteComponent(sprite: Sprite(barMiddle));
    var barBottomSprite = SpriteComponent(sprite: Sprite(barBottom));

    var fillerSprite = SpriteComponent(sprite: Sprite(filler));

    var textPaint = TextPaint(
      style: TextStyle(
        color: Color.fromRGBO(212, 142, 55, 1),
        fontSize: 25,
        fontFamily: 'Roboto',
      ),
    );

    var levelText = TextComponent(
      text: this.levelNumber.toString(),
      textRenderer: textPaint
    );

    adjustSize(backTopSprite);
    adjustSize(backMiddleSprite);
    adjustSize(backBottomSprite);

    adjustSize(barTopSprite);
    adjustSize(barMiddleSprite);
    adjustSize(barBottomSprite);

    adjustSize(fillerSprite);

    backTopSprite.position = Vector2(0, 0);
    barTopSprite.position = Vector2(0, 0);

    backMiddleSprite.position = Vector2(0, backTopSprite.position.y + backTopSprite.height);
    barMiddleSprite.position = Vector2(0, barTopSprite.position.y + barTopSprite.height);

    backBottomSprite.position = Vector2(0, backMiddleSprite.position.y + backMiddleSprite.height);
    barBottomSprite.position = Vector2(0, barMiddleSprite.position.y + barMiddleSprite.height);

    fillerSprite.anchor = Anchor.bottomCenter;
    fillerSprite.position = Vector2(
        backBottomSprite.size.x/2,
        backBottomSprite.position.y+1
    );

    _fillerControl = fillerSprite;
    _fillerFullSize = fillerSprite.size.y;

    levelText.position = Vector2(
        barBottomSprite.width/2-levelText.width/2,
        barBottomSprite.y+barBottomSprite.height*0.5
    );

    add(backTopSprite);
    add(backMiddleSprite);
    add(backBottomSprite);

    add(barTopSprite);
    add(barMiddleSprite);
    add(barBottomSprite);

    add(fillerSprite);
    add(levelText);
  }

  void adjustSize(SpriteComponent component){
    component.size = Vector2(component.width*_scale, component.height*_scale);
  }
}