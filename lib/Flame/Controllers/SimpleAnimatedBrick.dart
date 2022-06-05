import 'dart:math';
import 'dart:ui';

import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';

import '../UiComponents/CompletedWordsZone/WordSprite.dart';

class SimpleAnimatedBrick {

  final String word;
  final String colorCode;
  final double requiredBrickHeight;
  final double spawnX;
  final double spawnY;
  final double fallToY;
  final double brickFallDuration;

  late Component uiElement;

  late WordSprite _wordSprite;

  SimpleAnimatedBrick({
    required this.word,
    required this.colorCode,
    required this.requiredBrickHeight,
    required this.spawnX,
    required this.spawnY,
    required this.fallToY,
    required this.brickFallDuration
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
      CurvedEffectController(brickFallDuration, CustomBounceCurve._())
    );

    //var turnSign = _random.nextBool() ? 1 : -1;
    //final flyRotateEffect = RotateEffect.to(turnSign * pi * 2/40, EffectController(duration: 2));

    _wordSprite.add(_fallEffect);
    //_wordSprite.add(flyRotateEffect);
  }
}

class CustomBounceCurve extends Curve {
  const CustomBounceCurve._();

  @override
  double transformInternal(double t) {
    var res = _bounce(t);
    //print("${t},${res}");
    return res;
  }

  double _bounce(double t) {
    if (t < 1.0 / 2.75) {
      return 7.5625 * t * t;
    } else if (t < 2 / 2.75) {
      t -= 1.5 / 2.75;
      return 4.629 * t * t + 0.85;
    } else if (t < 2.5 / 2.75) {
      t -= 2.25 / 2.75;
      return 7.5625 * t * t + 0.9375;
    }
    t -= 2.625 / 2.75;
    return 7.5625 * t * t + 0.984375;
  }
}
