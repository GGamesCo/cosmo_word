import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:cosmo_word/Models/Events/InputCompletedEventArgs.dart';
import 'package:cosmo_word/UiComponents/StubGame/RocketChallengeZone.dart';

import '../../UiComponents/StubGame/WordSprite.dart';
import '../Abstract/ChallengeZoneController.dart';

class StubChallengeZoneController implements ChallengeZoneController {
  @override
  late Component rootUiControl;

  StubChallengeZoneController(){
    rootUiControl = RocketChallengeZone();
  }

  @override
  Future<void> init() async {

  }

  @override
  Future<void> onStart() async {
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    var wordSprite = WordSprite();
    final effect = MoveAlongPathEffect(
      Path() ..quadraticBezierTo(0, 0, 0, 450),
      EffectController(duration: 3.5),
    );
    wordSprite.add(effect);
    rootUiControl.add(wordSprite);
  }

  @override
  void onDispose() {
  }
}