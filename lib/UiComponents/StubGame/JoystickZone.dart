import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../../main.dart';


class JoystickZone extends SpriteComponent with HasGameRef<SpaceShooterGame>, Tappable {

  final Function tapCallback;

  JoystickZone({required this.tapCallback});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('joystick.png');

    position = Vector2(0, 570);
    width = 400;
    height = 273;
    anchor = Anchor.topLeft;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    tapCallback();
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print("tap down");
    return true;
  }

  @override
  bool onTapCancel() {
    print("tap cancel");
    return true;
  }
}