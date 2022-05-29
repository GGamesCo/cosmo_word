import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../BrickWordChallenge.dart';

class CompletedWordsZoneUiControl extends RectangleComponent with HasGameRef<BrickWordChallenge> {

  final Vector2 viewportSize;
  final Vector2 viewportPosition;

  final Vector2 containerSize;
  final Vector2 containerPosition;

  CompletedWordsZoneUiControl({
    required this.viewportSize,
    required this.viewportPosition,
    required this.containerSize,
    required this.containerPosition
  }) : super(position: viewportPosition, size: viewportSize);

  late RectangleComponent _container;

  @override
  Future<void> onLoad() async {
    setColor(Colors.blue);

    _container = RectangleComponent(size: containerSize, position: containerPosition);
    _container.setColor(Colors.red);


    add(_container);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _container.size.y = 100;
    paintImage(canvas: canvas, rect: rect, image: image)
  }

}