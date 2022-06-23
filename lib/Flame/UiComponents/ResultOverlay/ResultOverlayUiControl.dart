import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';

class ResultOverlayUiControl<G extends FlameGame> extends SpriteComponent with HasGameRef<G> {

  final bool isSuccess;
  ResultOverlayUiControl({required this.isSuccess});

  @override
  Future<void> onLoad() async {
    if(isSuccess)
      sprite = await gameRef.loadSprite('overlays/success-overlay.png');
    else
      sprite = await gameRef.loadSprite('overlays/fail-overlay.png');

    position = Vector2(0, 0);
    anchor = Anchor.topLeft;

    width = gameRef.size.x;
    height = gameRef.size.y;

    setOpacity(0);

    var opacityEffect = OpacityEffect.to(
        1,
        EffectController(duration: 0.3, reverseDuration: 0.3)
    );

    add(opacityEffect);
  }
}