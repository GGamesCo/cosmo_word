import 'package:flame/components.dart';

class WordJoystickComponent extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('widget/shakeBtn.png');
  }
}