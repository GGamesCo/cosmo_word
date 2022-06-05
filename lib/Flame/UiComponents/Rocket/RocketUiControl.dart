import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';

class RocketUiControl extends SpriteComponent {

  final int requiredHeight;

  RocketUiControl({required this.requiredHeight});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await Flame.images.load("rocket/rocket.png");
    sprite = Sprite(image);

    anchor = Anchor.topCenter;

    var scale = requiredHeight/image.size.y;
    size = Vector2(image.size.x*scale, image.size.y*scale);
  }
}