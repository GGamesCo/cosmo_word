
import 'package:flame/components.dart';

import '../../main.dart';
import '../WordGame.dart';

class Scene extends SpriteComponent with HasGameRef<WordGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}