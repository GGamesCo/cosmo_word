
import 'package:flame/components.dart';

import '../../main.dart';
import '../BrickWordChallenge.dart';

class Scene extends SpriteComponent with HasGameRef<BrickWordChallenge> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}