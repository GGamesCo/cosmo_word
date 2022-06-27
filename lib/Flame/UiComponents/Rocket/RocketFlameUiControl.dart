import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class RocketFlameUiControl extends RectangleComponent{

  final double requiredFlameWidth;

  RocketFlameUiControl({required this.requiredFlameWidth});

  Future<void> onLoad() async {
    var imageInstance = await Flame.images.load('rocket/flame.png');

    var scale = requiredFlameWidth / (imageInstance.size.x / 16);
    final flameSize = Vector2(requiredFlameWidth, imageInstance.size.y*scale);

    size = flameSize;
    size.x = size.x;
    anchor = Anchor.topCenter;

    var spritesheet = SpriteSheet(
      image: imageInstance,
      srcSize: Vector2(imageInstance.size.x/16, imageInstance.size.y),
    );

    final animation = spritesheet.createAnimation(row: 0, stepTime: 0.03);

    final animComponent = SpriteAnimationComponent(
      animation: animation,
      position: Vector2(0, 0),
      size: flameSize,
    );

    add(animComponent);
  }

}