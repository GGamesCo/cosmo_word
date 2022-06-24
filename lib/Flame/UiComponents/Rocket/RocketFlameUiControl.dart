import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

class RocketFlameUiControl extends RectangleComponent{

  final double requiredFlameWidth;

  final spriteSheetSize = Vector2(1080, 1295);

  RocketFlameUiControl({required this.requiredFlameWidth});

  Future<void> onLoad() async {
    var scale = requiredFlameWidth / spriteSheetSize.x;
    final flameSize = Vector2(requiredFlameWidth, spriteSheetSize.y*scale);

    size = flameSize;
    anchor = Anchor.topCenter;

    var imageInstance = await Flame.images.load('rocket/flame.png');
    var spritesheet = SpriteSheet(
      image: imageInstance,
      srcSize: spriteSheetSize,
    );

    final animation = spritesheet.createAnimation(row: 0, stepTime: 0.09);

    final animComponent = SpriteAnimationComponent(
      animation: animation,
      position: Vector2(0, 0),
      size: flameSize,
    );

    add(animComponent);
  }

}