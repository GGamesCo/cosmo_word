
import 'package:flame/components.dart';

import '../../main.dart';
import '../TimeChallengeGame.dart';

class Scene extends SpriteComponent with HasGameRef<TimeChallengeGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}