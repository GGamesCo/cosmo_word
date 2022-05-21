import 'dart:async';
import 'package:event/event.dart';
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';


class WordSprite extends SpriteComponent with CollisionCallbacks {

  final String word;
  final String color;

  double _oneWordWidthK = 50;

  Event<BrickCollisionEventArgs> onCollisionDetected = Event<BrickCollisionEventArgs>();

  RectangleHitbox _hitbox = RectangleHitbox();

  WordSprite({required this.word, required this.color});

  @override
  Future<void> onLoad() async {
    add(_hitbox);

    var spriteName = "${word.length}-${color}.png";

    final image = await Flame.images.load("bricks/${spriteName}");
    sprite = Sprite(image);

    var expectedImgWidth = _oneWordWidthK*word.length;
    var scaleFactor = image.width/expectedImgWidth;

    position = Vector2(40, 0);
    width = image.width/scaleFactor;
    height = image.height/scaleFactor;
    anchor = Anchor.topLeft;
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    onCollisionDetected.broadcast(BrickCollisionEventArgs(collisionPoints: points));
  }

  void setNewAnchorPoint(Set<Vector2> collisionPoints) {
    anchor = Anchor.bottomRight;
    position = Vector2(position.x + width, position.y + height);
  }
}

class BrickCollisionEventArgs extends EventArgs {
  final Set<Vector2> collisionPoints;

  BrickCollisionEventArgs({required this.collisionPoints});
}