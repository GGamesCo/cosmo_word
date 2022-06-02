import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../../WordGame.dart';
import '../CompletedWordsZone/CompletedWordsZoneUiControl.dart';

class RocketChallengeZoneUiControl extends RectangleComponent with HasGameRef<WordGame> {

  RocketChallengeZoneUiControl({required position, required size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    setColor(Colors.transparent);

    var bgImage = await gameRef.loadSprite('rocket_challenge.png');
    var sprite = SpriteComponent(sprite: bgImage, size: size);
    add(sprite);


    var tester = RectangleComponent(
      size: Vector2(10, 10),
      position: Vector2(175.84, 174.86)
    );

    final effect = ColorEffect(
      Colors.red,
      const Offset(0.0, 1),
      EffectController(duration: 0),
    );

    //tester.add(effect);
    //add(tester);
  }
}