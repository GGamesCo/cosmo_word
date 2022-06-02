import 'dart:async' as DartAsync;
import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/UiComponents/Rocket/RocketBoxUiControl.dart';
import 'package:flame/components.dart';
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

  late double _availableFlyHeight;

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
    _availableFlyHeight = zoneSize.y;

    _rocketBoxUiControl = RocketBoxUiControl(size: zoneSize);
    _rocketUiControl = RocketUiControl(requiredHeight: rocketHeight);
    _rocketUiControl.anchor = Anchor.topCenter;
    _rocketUiControl.position = Vector2(zoneSize.x/2, 0);

    rootUiControl.add(_rocketBoxUiControl);
    rootUiControl.add(_rocketUiControl);

    _secondsLeft = challengeConfig.totalTimeSec;
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
    var progress = _secondsLeft/challengeConfig.totalTimeSec;
    var newHeight = _availableFlyHeight * (1-progress);
    _rocketUiControl.position = Vector2(_rocketUiControl.position.x, newHeight);
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    _secondsLeft += challengeConfig.wordCompletionTimeRewardSec;
  }

  @override
  void onDispose() {

  }
}