import 'package:flame/components.dart';
import 'package:event/event.dart';
import 'package:flame/events.dart';

class ShakeBtnComponent extends SpriteComponent with HasGameRef, Tappable {
  Event tap = Event();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('widget/shakeBtn.png');
  }

  @override
  bool onTapUp(TapUpInfo event){
    tap.broadcast();
    return true;
  }
}