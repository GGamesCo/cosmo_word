
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../../main.dart';
import '../TimeChallengeGame.dart';

class Scene<G extends FlameGame> extends SpriteComponent with HasGameRef<G> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player-sprite.png');
    anchor = Anchor.topLeft;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}