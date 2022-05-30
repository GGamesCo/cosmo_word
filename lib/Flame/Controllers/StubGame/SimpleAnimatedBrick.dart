import 'dart:math';
import 'dart:ui';

import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

import '../../UiComponents/CompletedWordsZone/WordSprite.dart';

class SimpleAnimatedBrick {

  final String word;
  final String colorCode;
  final double requiredBrickHeight;
  final double spawnX;
  final double spawnY;
  final double fallToY;
  final double brickFallSpeed;

  late Component uiElement;

  late WordSprite _wordSprite;

  SimpleAnimatedBrick({
    required this.word,
    required this.colorCode,
    required this.requiredBrickHeight,
    required this.spawnX,
    required this.spawnY,
    required this.fallToY,
    required this.brickFallSpeed
  });

  void init(){
    _wordSprite = WordSprite(
      word: this.word,
      color: this.colorCode,
      requiredBrickHeight: requiredBrickHeight,
      spawnX: spawnX,
      spawnY: spawnY
    );
    _setupAnimationsEffects();
    uiElement = _wordSprite;
  }

  late MoveToEffect _fallEffect;

  void _setupAnimationsEffects(){
    _fallEffect = MoveToEffect(
      Vector2(spawnX, fallToY),
      //EffectController(speed: brickFallSpeed),
      CurvedEffectController(1.5, Curves.bounceOut)
    );

    //var turnSign = _random.nextBool() ? 1 : -1;
    //final flyRotateEffect = RotateEffect.to(turnSign * pi * 2/40, EffectController(duration: 2));

    _wordSprite.add(_fallEffect);
    //_wordSprite.add(flyRotateEffect);
  }
}