import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:event/event.dart';
import 'package:flame/collisions.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class WordSprite extends SpriteComponent with CollisionCallbacks {

  final String word;
  final String color;

  double _oneWordWidthK = 50;

  Event<BrickCollisionEventArgs> onCollisionDetected = Event<BrickCollisionEventArgs>();

  final Map<String, Color> _textColors = {
    'r': Color.fromRGBO(182, 82, 55, 1),
    'g': Color.fromRGBO(107, 160, 22, 1),
    'y': Color.fromRGBO(209, 129, 30, 1),
  };

  WordSprite({required this.word, required this.color});

  @override
  Future<void> onLoad() async {
    var spriteName = "${word.length}-${color}.png";

    final image = await Flame.images.load("bricks/${spriteName}");
    sprite = Sprite(image);

    var expectedImgWidth = _oneWordWidthK*word.length;
    var scaleFactor = image.width/expectedImgWidth;

    var xPosition = (5-word.length)*20.0;

    position = Vector2(50+xPosition, 0);

    width = image.width/scaleFactor;
    height = image.height/scaleFactor;
    anchor = Anchor.topLeft;

    var textPaint = TextPaint(
      style: TextStyle(
        color: _textColors[color],
        fontSize: 30.0,
        letterSpacing: 32,
        fontFamily: 'Roboto',
      ),
    );
    
    add(TextComponent(text: word, textRenderer: textPaint, position: Vector2(0, 4)));

    //for layers
    //add(RectangleHitbox.relative(Vector2(1, 0.95), parentSize: size));
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {

    var globalSystemCords = points.first;

    var x1 = globalSystemCords.x-(position.x);
    var y1 = globalSystemCords.y-(position.y);
    var a = angle;

    var xCord = x1 * cos(a) + y1 * sin(a);
    var yCord = -x1 * sin(a) + y1 * cos(a);

    var tester = RectangleComponent(
        size: Vector2(10, 10),
        position: Vector2(xCord*1, yCord)
    );

    final effect = ColorEffect(
      Colors.blue,
      const Offset(0.0, 1),
      EffectController(duration: 0),
    );


    tester.add(effect);
    //add(tester);
    onCollisionDetected.broadcast(BrickCollisionEventArgs(collisionPoints: points));
  }

  void setNewAnchorPoint(Set<Vector2> collisionPoints) {

    var globalSystemCords = collisionPoints.first;

    var x1 = globalSystemCords.x-(position.x);
    var y1 = globalSystemCords.y-(position.y);
    var a = angle;

    var xCord = x1 * cos(a) + y1 * sin(a);
    var yCord = -x1 * sin(a) + y1 * cos(a);

    anchor = Anchor(xCord/width, yCord/height);
    position = Vector2(globalSystemCords.x, globalSystemCords.y);
  }
}

class BrickCollisionEventArgs extends EventArgs {
  final Set<Vector2> collisionPoints;

  BrickCollisionEventArgs({required this.collisionPoints});
}