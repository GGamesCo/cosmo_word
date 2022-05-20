import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../../main.dart';


class RocketChallengeZone extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('rocket_challenge.png');

    position = Vector2(0, 0);
    width = 400;
    height = 500;
    anchor = Anchor.topLeft;
  }
}