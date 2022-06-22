import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:flame/components.dart';
import 'package:event/event.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class HintBtnComponent extends SpriteComponent with HasGameRef, Tappable {
  Event tap = Event();
  final String spriteName;

  HintBtnComponent({required this.spriteName});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.topCenter;
    sprite = await gameRef.loadSprite('widget/hintBtn.png');

    var badgeBg = await gameRef.loadSprite('common_controls/priceBadgeBg.png');
    var badgeComponent = SpriteComponent()
    ..sprite = badgeBg
      ..size = Vector2(size.x, size.x*0.5)
    ..position = Vector2(0, size.y*0.6);
    //debugMode = true;
    add(badgeComponent);

    final style = TextStyle(color: Color.fromRGBO(35, 97, 114, 1), fontFamily: "Roboto");
    final regular = TextPaint(style: style);
    var text = TextComponent(text: PriceListConfig.HINT_PRICE.toString(), textRenderer: regular)
      ..anchor = Anchor.center
  //    ..size = badgeComponent.size
      ..position = Vector2(badgeComponent.size.x/1.6, badgeComponent.y + badgeComponent.size.y/2.4);

    add(text);
  }

  @override
  bool onTapUp(TapUpInfo event){
    tap.broadcast();
    return true;
  }
}