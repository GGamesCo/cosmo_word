import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../../BrickWordChallenge.dart';
import '../CompletedWordsZone/CompletedWordsZoneUiControl.dart';


class StubChallengeZoneUiControl extends RectangleComponent with HasGameRef<BrickWordChallenge> {

  StubChallengeZoneUiControl({required position, required size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    setColor(Colors.green);
    /*
    var bgImage = await gameRef.loadSprite('rocket_challenge.png');
    var sprite = SpriteComponent(sprite: bgImage, size: size);
    add(sprite);
     */

    add(CompletedWordsZoneUiControl(
      viewportSize: Vector2(100, 300),
      viewportPosition: Vector2(50, 100),
      containerSize: Vector2(80, 580),
      containerPosition: Vector2(0, -50)
    ));

    ParallaxComponent();

    var floorHitbox = RectangleHitbox(
        position: Vector2(
            0,
            height-1
        ),
        size: Vector2(width, 1)
    );
    add(floorHitbox);

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