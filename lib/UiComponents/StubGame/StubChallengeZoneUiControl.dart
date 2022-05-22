import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../../main.dart';

class StubChallengeZoneUiControl extends RectangleComponent with HasGameRef<SpaceShooterGame> {


  StubChallengeZoneUiControl({required position, required size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    var bgImage = await gameRef.loadSprite('rocket_challenge.png');
    var sprite = SpriteComponent(sprite: bgImage, size: size);
    add(sprite);

    var floorHitbox = RectangleHitbox(
        position: Vector2(
            0,
            height-1
        ),
        size: Vector2(width, 1)
    );
    add(floorHitbox);
  }
}