import 'dart:async';
import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/UiComponents/Rocket/RocketBoxUiControl.dart';
import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/ITimerController.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';


import '../../ElementsLayoutBuilder.dart';
import '../../UiComponents/Rocket/RocketUiControl.dart';

class RocketZoneController implements UiControllerBase {

  final ElementLayoutData layoutData;
  final double rocketHeightMultiplier;

  late RocketBoxUiControl _rocketBoxUiControl;
  late RocketUiControl _rocketUiControl;

  @override
  late Component rootUiControl;

  Future<void> get uiComponentLoadedFuture => Future.wait([_rocketBoxUiControl.loaded, _rocketUiControl.loaded]);
  
  RocketZoneController({
    required this.layoutData,
    required this.rocketHeightMultiplier
  });

  @override
  Future initAsync() {

    var rect = RectangleComponent(size: layoutData.size);
    rect.setColor(Colors.transparent);
    rect.anchor = layoutData.anchor;
    rect.position = layoutData.position;
    rootUiControl = rect;

    _rocketBoxUiControl = RocketBoxUiControl(size: layoutData.size);
    _rocketUiControl = RocketUiControl(requiredHeight: layoutData.size.y*rocketHeightMultiplier);
    _rocketUiControl.anchor = Anchor.topCenter;
    _rocketUiControl.position = Vector2(layoutData.size.x/2, 0);
    _rocketUiControl.setOpacity(0);

    rootUiControl.add(_rocketBoxUiControl);
    rootUiControl.add(_rocketUiControl);

    return Completer().completeAndReturnFuture();
  }

  void initRocketPosition(int secondsLeft, int totalTime){
    var rocketPosition = calculateRocketPosition(secondsLeft, totalTime);
    _rocketUiControl.position = Vector2(rocketPosition.x, rocketPosition.y);
    _rocketUiControl.setOpacity(1);
  }

  void onCountDownUpdated(int secondsLeft, int totalTime){
    _rocketBoxUiControl.updateTimerState(secondsLeft);
    updateRocketPosition(secondsLeft, totalTime);
    if (secondsLeft == 0 && _rocketUiControl.parent == null) {
      rootUiControl.remove(_rocketUiControl);
    }
  }

  void animateNewInput(double completedWordsHeight){
    _rocketBoxUiControl.animateHeightTimer(completedWordsHeight);
    _rocketUiControl.playFlameAnim();
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

  void renderReachedHeight(double currentReachedHeight) {
    _rocketUiControl.renderReachedHeight(currentReachedHeight);
  }
}