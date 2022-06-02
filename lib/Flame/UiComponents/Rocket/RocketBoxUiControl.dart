import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class RocketBoxUiControl extends SpriteComponent {

  RocketBoxUiControl({required size}) : super(size: size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final image = await Flame.images.load("rocket/rocketFrame.png");
    sprite = Sprite(image);
  }


  void updateTimerState(int secondsLeft) {

  }
}