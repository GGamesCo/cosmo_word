import 'dart:math';
import 'dart:ui';

import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../../UiComponents/StubGame/WordSprite.dart';

class SimpleAnimatedBrick {
  final String word;
  final String colorCode;

  late Component uiElement;

  late WordSprite _wordSprite;
  bool _isLanded = false;
  List<Effect> _appliedFallEffects = [];

  SimpleAnimatedBrick({required this.word, required this.colorCode});

  void init(){
    _wordSprite = WordSprite(word: this.word, color: this.colorCode);
    _wordSprite.onCollisionDetected + _onWordCollisionDetected;
    _setupAnimationsEffects();
    uiElement = _wordSprite;
  }

  void _setupAnimationsEffects(){
    final fallEffect = MoveAlongPathEffect(
      Path() ..quadraticBezierTo(0, 0, 0, 450),
      EffectController(duration: 2),
    );

    final flyRotateEffect = RotateEffect.to(pi*2/40, EffectController(duration: 2));

    _wordSprite.add(fallEffect);
    _wordSprite.add(flyRotateEffect);
  }

  void _onWordCollisionDetected(BrickCollisionEventArgs? args) {
    if(_isLanded)
      return;

    _isLanded = true;

    var existingEffects = _wordSprite.children.where((element) => element is Effect);
    _wordSprite.removeAll(existingEffects);

    final rotateToZeroEffect = RotateEffect.to(0, EffectController(duration: 0.1));
    _wordSprite.setNewAnchorPoint(args!.collisionPoints);
    _wordSprite.add(rotateToZeroEffect);
  }
}