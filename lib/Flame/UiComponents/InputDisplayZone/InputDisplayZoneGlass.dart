import 'package:flame/components.dart';
import '../../BrickWordChallenge.dart';


class InputDisplayZoneGlass extends SpriteComponent with HasGameRef<BrickWordChallenge> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('input_display/glass.png');

    var multiplier = sprite!.image.width/gameRef.size.x;

    width = sprite!.image.width/multiplier * 0.95;
    height = sprite!.image.height/multiplier * 0.95;
    anchor = Anchor.topCenter;

    position = Vector2(gameRef.size.x/2, 0);
  }
}