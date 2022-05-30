import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../../BrickWordChallenge.dart';

class CompletedWordsZoneUiControl extends RectangleComponent with HasGameRef<BrickWordChallenge> {

  final Vector2 viewportSize;
  final Vector2 viewportPosition;
  final double bricksContainerHeight;
  double scrollOffset;

  CompletedWordsZoneUiControl({
    required this.viewportSize,
    required this.viewportPosition,
    required this.bricksContainerHeight,
    required this.scrollOffset
  }) : super(position: viewportPosition, size: viewportSize);

  late RectangleComponent _bricksContainer;

  @override
  Future<void> onLoad() async {
    setColor(Colors.blue);

    _bricksContainer = RectangleComponent(
        size: Vector2(viewportSize.x, bricksContainerHeight),
        position: Vector2(0, viewportSize.y + scrollOffset)
    );
    _bricksContainer.anchor = Anchor.bottomLeft;
    _bricksContainer.setColor(Colors.red);
     add(_bricksContainer);

    var floorHitbox = RectangleHitbox(
        position: Vector2(
            0,
            _bricksContainer.height - 1
        ),
        size: Vector2(_bricksContainer.width, 1)
    );
    _bricksContainer.add(floorHitbox);
  }

  void attachNewBrick(Component brick){
    _bricksContainer.add(brick);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.clipRect(this.size.toRect());
  }

  void updateScrollOffset(double scrollStepSize, double duration) {
    scrollOffset = scrollOffset + scrollStepSize;
    //_bricksContainer.position.y = bricksContainerHeight + scrollOffset;

    var scrollEffect = MoveAlongPathEffect(
      Path() ..quadraticBezierTo(0, 0, 0, scrollStepSize),
      EffectController(duration: duration),
    );

    _bricksContainer.add(scrollEffect);
  }

}