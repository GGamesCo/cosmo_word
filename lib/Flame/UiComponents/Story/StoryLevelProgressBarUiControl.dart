import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class StoryLevelProgressBarUiControl extends RectangleComponent {

  final double requiredWidth;

  late double _scale;

  late SpriteComponent _fillerControl;
  late double _fillerFullSize;

  StoryLevelProgressBarUiControl({required this.requiredWidth});

  void setProgress(double p){
    _fillerControl.size.y = _fillerFullSize*p;
  }

  @override
  Future<void> onLoad() async {
    var backTop = await Flame.images.load("level_progress_bar/back-top.png");
    var backMiddle = await Flame.images.load("level_progress_bar/back-middle.png");
    var backBottom = await Flame.images.load("level_progress_bar/back-bottom.png");

    var barTop = await Flame.images.load("level_progress_bar/bar-top.png");
    var barMiddle = await Flame.images.load("level_progress_bar/bar-middle.png");
    var barBottom = await Flame.images.load("level_progress_bar/bar-bottom.png");

    var filler = await Flame.images.load("level_progress_bar/filler.png");

    _scale = requiredWidth/barMiddle.width;

    var backTopSprite = SpriteComponent(sprite: Sprite(backTop));
    var backMiddleSprite = SpriteComponent(sprite: Sprite(backMiddle));
    var backBottomSprite = SpriteComponent(sprite: Sprite(backBottom));

    var barTopSprite = SpriteComponent(sprite: Sprite(barTop));
    var barMiddleSprite = SpriteComponent(sprite: Sprite(barMiddle));
    var barBottomSprite = SpriteComponent(sprite: Sprite(barBottom));

    var fillerSprite = SpriteComponent(sprite: Sprite(filler));

    adjustSize(backTopSprite);
    adjustSize(backMiddleSprite);
    adjustSize(backBottomSprite);

    adjustSize(barTopSprite);
    adjustSize(barMiddleSprite);
    adjustSize(barBottomSprite);

    adjustSize(fillerSprite);

    backTopSprite.position = Vector2(0, 0);
    barTopSprite.position = Vector2(0, 0);

    backMiddleSprite.position = Vector2(0, backTopSprite.position.y + backTopSprite.height);
    barMiddleSprite.position = Vector2(0, barTopSprite.position.y + barTopSprite.height);

    backBottomSprite.position = Vector2(0, backMiddleSprite.position.y + backMiddleSprite.height);
    barBottomSprite.position = Vector2(0, barMiddleSprite.position.y + barMiddleSprite.height);

    fillerSprite.anchor = Anchor.bottomCenter;
    fillerSprite.position = Vector2(
        backBottomSprite.size.x/2,
        backBottomSprite.position.y
    );

    _fillerControl = fillerSprite;
    _fillerFullSize = fillerSprite.size.y;

    add(backTopSprite);
    add(backMiddleSprite);
    add(backBottomSprite);

    add(barTopSprite);
    add(barMiddleSprite);
    add(barBottomSprite);

    add(fillerSprite);
  }

  void adjustSize(SpriteComponent component){
    component.size = Vector2(component.width*_scale, component.height*_scale);
  }
}