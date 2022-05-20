import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../main.dart';


class Scene extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}