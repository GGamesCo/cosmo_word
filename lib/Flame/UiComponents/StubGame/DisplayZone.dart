import 'dart:async';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../../../main.dart';
import '../../BrickWordChallenge.dart';




class StaticBackgroundUiControl extends SpriteComponent with HasGameRef<BrickWordChallenge> {

  final String bgFileName;
  StaticBackgroundUiControl({required this.bgFileName});

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('backgrounds/${bgFileName}');

    position = Vector2(gameRef.size.x/2, 0);
    anchor = Anchor.topCenter;

    var scale = sprite!.image.height/gameRef.size.y;

    width = sprite!.image.width / scale;
    height = sprite!.image.height / scale;
  }
}