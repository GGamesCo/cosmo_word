import 'dart:async' as DartAsync;
import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/UiComponents/Rocket/RocketBoxUiControl.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';


import '../../UiComponents/Rocket/RocketUiControl.dart';

class RocketZoneController implements UiControllerBase {

  final Vector2 zoneSize;
  final Vector2 zonePosition;
  final int rocketHeight;

  late RocketBoxUiControl _rocketBoxUiControl;
  late RocketUiControl _rocketUiControl;

  @override
  late Component rootUiControl;

  DartAsync.Future<void> get uiComponentLoadedFuture => Future.wait([_rocketBoxUiControl.loaded, _rocketUiControl.loaded]);
  
  RocketZoneController({
    required this.zoneSize,
    required this.zonePosition,
    required this.rocketHeight
  });

  @override
  void init() {

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
  }

  void initRocketPosition(int secondsLeft, int totalTime){
    var rocketPosition = calculateRocketPosition(secondsLeft, totalTime);
    _rocketUiControl.position = Vector2(rocketPosition.x, rocketPosition.y);
    _rocketUiControl.setOpacity(1);
  }

  void onCountDownUpdated(int secondsLeft, int totalTime){
    _rocketBoxUiControl.updateTimerState(secondsLeft);
    updateRocketPosition(secondsLeft, totalTime);
    if (secondsLeft == 0) {
      rootUiControl.remove(_rocketUiControl);
    }
  }

  void updateRocketPosition(int secondsLeft, int totalTime){
    var rocketPosition = calculateRocketPosition(secondsLeft, totalTime);
    final effect = MoveToEffect(
        Vector2(rocketPosition.x, rocketPosition.y),
        EffectController(duration: 1, curve: Curves.linear)
    );
    _rocketUiControl.add(effect);
  }

  Vector2 calculateRocketPosition(int secondsLeft, int totalTime){
    var topRocketBound = _rocketBoxUiControl.flyBounds.x;
    var bottomRocketBound = _rocketBoxUiControl.flyBounds.y-_rocketUiControl.requiredHeight;

    var availableFlyDistance = bottomRocketBound - topRocketBound;

    var progress = secondsLeft/totalTime;
    var newHeight = _rocketBoxUiControl.flyBounds.x + availableFlyDistance * (1-progress);
    return Vector2(_rocketUiControl.position.x, newHeight);
  }
}