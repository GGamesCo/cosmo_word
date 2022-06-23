import 'dart:math';

import 'package:cosmo_word/Flame/ElementsLayoutBuilder.dart';
import 'package:cosmo_word/Flame/Models/Events/SymbolInputAddedEventArgs.dart';
import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import '../../../../Flame/Models/Events/InputCompletedEventArgs.dart';
import '../Joystick/JoystickSymbolSpriteComponent.dart';

class PreviewZoneComponent extends SpriteComponent with HasGameRef {

  final ElementLayoutData layoutData;
  final Vector2 btnSize = Vector2(40,40);

  PositionComponent symbolsHolder = PositionComponent();
  int count = 0;

  PreviewZoneComponent({required this.layoutData});

  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('widget/wordPreviewBgZ1.png');
    this.size = layoutData.size;
    this.anchor = layoutData.anchor;
    this.position = layoutData.position;

    symbolsHolder = new PositionComponent();
    symbolsHolder.anchor = Anchor.topCenter;
    symbolsHolder.size = Vector2(0, btnSize.y);
    symbolsHolder.position = Vector2(size.x/2, (size.y - symbolsHolder.size.y) / 2);
    add(symbolsHolder);
    var spriteZ0 = SpriteComponent(sprite: await gameRef.loadSprite('widget/wordPreviewBg.png'));
    spriteZ0.size = size;
    add(spriteZ0);
  }

  void onSymbolAdded(SymbolInputAddedEventArgs eventArgs) async {
      var btn = new JoystickSymbolSpriteComponent(eventArgs.lastInputSymbol);
      btn.isActive = true;
      btn.symbolId = eventArgs.lastInputSymbol;
      btn.size = btnSize;
      btn.anchor = Anchor.topCenter;
      var xOffset  = btnSize.x * count;
      btn.position = Vector2(gameRef.size.x, 0);
      symbolsHolder.add(btn);
      print("symbolsHolder.children.length = ${symbolsHolder.children.length}");

      var holderSize = 0.0;
      symbolsHolder.children.forEach((element) {
        holderSize += (element as PositionComponent).width;
      });

      btn.add(MoveEffect.to(Vector2(xOffset, 0), EffectController(duration: 0.2)));
      symbolsHolder.size = Vector2(holderSize, symbolsHolder.height);
      print("symbolsHolder.size.x: " + symbolsHolder.size.x.toString());
      count++;
  }

  void onInputCompleted(InputCompletedEventArgs eventArgs){
    print("Input accepted");
    FlameAudio.play('success.mp3');
    reset((x) => {
      x.add(MoveEffect.to(Vector2(-gameRef.size.x - btnSize.x, 0), EffectController(duration: 0.5)))
    });
  }

  void onInputRejected(){
    print("Input rejected");
    FlameAudio.play('fail.mp3');
    reset((x) => {
      x.add(MoveEffect.to(Vector2(gameRef.size.x, 0), EffectController(duration: 0.5)))
    });
  }

  void reset(void func(Component)){
    symbolsHolder.children.forEach((element) async {
      func(element);
      symbolsHolder.size = Vector2(symbolsHolder.size.x - btnSize.x, symbolsHolder.height);
      await Future.delayed(Duration(milliseconds: 500));
      element.removeFromParent();
    });

    count = 0;
    symbolsHolder.size = Vector2(0, symbolsHolder.height);
  }
}