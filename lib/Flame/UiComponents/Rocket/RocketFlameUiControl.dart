import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';

class RocketFlameUiControl extends RectangleComponent{

  final double requiredFlameWidth;

  RocketFlameUiControl({required this.requiredFlameWidth});

  Future<void> onLoad() async {
    var imageInstance = await Flame.images.load('rocket/flame.png');

    var scaleK = requiredFlameWidth / (imageInstance.size.x / 16);
    final flameSize = Vector2(requiredFlameWidth, imageInstance.size.y*scaleK);

    size = flameSize;
    size.x = size.x;
    anchor = Anchor.topCenter;

    var spritesheet = SpriteSheet(
      image: imageInstance,
      srcSize: Vector2(imageInstance.size.x/16, imageInstance.size.y),
    );

    final animation = spritesheet.createAnimation(row: 0, stepTime: 0.03);

    final animComponent = SpriteAnimationComponent(
      animation: animation,
      position: Vector2(0, 0),
      size: flameSize,
    );

    this.scale = Vector2(0.4, 0.4);

    add(animComponent);
  }

  void playFlameAnim(){
    var currentAnim = ScaleEffect.to(
        Vector2(1,1),
        EffectController(
            duration: 1,
            atMaxDuration: 1,
            reverseDuration: 0.7,
            repeatCount: 1,
            curve: Curves.ease
        )
    );
    add(currentAnim);
  }
}