import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../BrickWordChallenge.dart';
import '../../Controllers/StubGame/SimpleAnimatedBrick.dart';
import '../../Models/CompletedBrickData.dart';

class CompletedWordsZoneUiControl extends RectangleComponent with HasGameRef<BrickWordChallenge> {

  final Vector2 viewportSize;
  final Vector2 viewportPosition;

  final Vector2 containerSize;
  final Vector2 containerPosition;

  final int brickSizeFactor;

  CompletedWordsZoneUiControl({
    required this.viewportSize,
    required this.viewportPosition,
    required this.containerSize,
    required this.containerPosition,
    required this.brickSizeFactor
  }) : super(position: viewportPosition, size: viewportSize);

  late RectangleComponent _bricksContainer;

  @override
  Future<void> onLoad() async {
    setColor(Colors.blue);

    _bricksContainer = RectangleComponent(size: containerSize, position: containerPosition);
    _bricksContainer.setColor(Colors.red);

    var floorHitbox = RectangleHitbox(
        position: Vector2(
            0,
            _bricksContainer.height-1
        ),
        size: Vector2(width, 1)
    );
    add(floorHitbox);

    add(_bricksContainer);
  }

  void attachNewBrick(Component brick){
    _bricksContainer.add(brick);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.clipRect(this.size.toRect());
  }

}