import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';

import 'RocketFlameUiControl.dart';

class RocketUiControl extends RectangleComponent {

  final double requiredHeight;

  late RocketFlameUiControl _flameUiControl;

  RocketUiControl({required this.requiredHeight});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await Flame.images.load("rocket/rocket.png");

    anchor = Anchor.topCenter;
    var scale = requiredHeight/image.size.y;
    size = Vector2(image.size.x*scale, image.size.y*scale);

    var sprite = SpriteComponent(sprite: Sprite(image));
    sprite.size = size;

    _flameUiControl = RocketFlameUiControl(requiredFlameWidth: size.x*3);
    _flameUiControl.position = Vector2(sprite.size.x/2, requiredHeight*0.75);
    add(_flameUiControl);
    add(sprite);
  }

  void playFlameAnim(){
    _flameUiControl.playFlameAnim();
  }
}