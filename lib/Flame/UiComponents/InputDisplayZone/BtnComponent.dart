import 'package:flame/components.dart';
import 'package:event/event.dart';
import 'package:flame/events.dart';

class RoundBtnComponent extends SpriteComponent with HasGameRef, Tappable {
  Event tap = Event();
  final String spriteName;

  RoundBtnComponent({required this.spriteName});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite(this.spriteName);
  }

  @override
  bool onTapUp(TapUpInfo event){
    tap.broadcast();
    return true;
  }
}