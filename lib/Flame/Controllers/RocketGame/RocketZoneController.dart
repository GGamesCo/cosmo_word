import 'dart:async' as DartAsync;
import 'dart:math';
import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/UiComponents/Rocket/RocketBoxUiControl.dart';
import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';


import '../../Models/Configuration/RocketChallengeConfig.dart';
import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/Rocket/RocketUiControl.dart';

class RocketZoneController implements UiControllerBase {

  final Vector2 zoneSize;
  final Vector2 zonePosition;
  final int rocketHeight;
  final RocketChallengeConfig challengeConfig;

  late RocketBoxUiControl _rocketBoxUiControl;
  late RocketUiControl _rocketUiControl;

  late DartAsync.Timer _challengeCountDown;
  late int _secondsLeft;

  @override
  late Component rootUiControl;

  RocketZoneController({
    required this.zoneSize,
    required this.zonePosition,
    required this.rocketHeight,
    required this.challengeConfig
  });

  @override
  Future<void> init() async {

    var rect = RectangleComponent(size: zoneSize, position: zonePosition);
    rect.setColor(Colors.transparent);
    rootUiControl = rect;

    _rocketBoxUiControl = RocketBoxUiControl(size: zoneSize);
    _rocketUiControl = RocketUiControl(requiredHeight: rocketHeight);
    _rocketUiControl.anchor = Anchor.topCenter;
    _rocketUiControl.position = Vector2(zoneSize.x/2, 0);
    _rocketUiControl.setOpacity(0);

    rootUiControl.add(_rocketBoxUiControl);
    rootUiControl.add(_rocketUiControl);

    _rocketBoxUiControl.onLoadCompleted.subscribe(rocketBoxLoadCompleted);
  }

  void rocketBoxLoadCompleted(EventArgs? eventArgs){
    _secondsLeft = challengeConfig.totalTimeSec;

    var rocketPosition = calculateRocketPosition();
    _rocketUiControl.position = Vector2(rocketPosition.x, rocketPosition.y);
    _rocketUiControl.setOpacity(1);

    _challengeCountDown = DartAsync.Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          onCountDownUpdated();
        }
    );
  }

  void onCountDownUpdated(){
    _secondsLeft--;
    _rocketBoxUiControl.updateTimerState(_secondsLeft);
    updateRocketPosition();
    if (_secondsLeft == 0) {
      rootUiControl.remove(_rocketUiControl);
      _challengeCountDown.cancel();
    }
  }

  void updateRocketPosition(){
    var rocketPosition = calculateRocketPosition();
    final effect = MoveToEffect(
        Vector2(rocketPosition.x, rocketPosition.y),
        EffectController(duration: 1, curve: Curves.linear)
    );
    _rocketUiControl.add(effect);
  }

  Vector2 calculateRocketPosition(){
    var topRocketBound = _rocketBoxUiControl.flyBounds.x;
    var bottomRocketBound = _rocketBoxUiControl.flyBounds.y-_rocketUiControl.requiredHeight;

    var availableFlyDistance = bottomRocketBound - topRocketBound;

    var progress = _secondsLeft/challengeConfig.totalTimeSec;
    var newHeight = _rocketBoxUiControl.flyBounds.x + availableFlyDistance * (1-progress);

    return Vector2(_rocketUiControl.position.x, newHeight);
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    _secondsLeft = min(
      _secondsLeft + challengeConfig.wordCompletionTimeRewardSec,
      challengeConfig.totalTimeSec
    ) ;
  }

  @override
  void onDispose() {

  }
}