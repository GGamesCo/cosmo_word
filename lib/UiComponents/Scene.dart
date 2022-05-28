import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../main.dart';
import 'Joystick/WordJoystickComponent.dart';

class Scene extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;

    add(WordJoystickComponent()
    ..width = 250
    ..height = 250);
  }

  void move(Vector2 delta) {
    position = position + delta;
  }
}