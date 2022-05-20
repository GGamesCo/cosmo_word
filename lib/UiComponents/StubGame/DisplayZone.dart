import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../../main.dart';


class DisplayZone extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('display_zone.png');

    position = Vector2(0, 500);
    width = 400;
    height = 70;
    anchor = Anchor.topLeft;
  }
}