import 'package:flame/components.dart';
import '../../WordGame.dart';


class InputDisplayZoneCover extends SpriteComponent with HasGameRef<WordGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('input_display/display_input_cover.png');

    var multiplier = sprite!.image.width/gameRef.size.x;

    width = sprite!.image.width/multiplier;
    height = sprite!.image.height/multiplier;
    anchor = Anchor.topCenter;

    position = Vector2(gameRef.size.x/2, 0);
  }
}