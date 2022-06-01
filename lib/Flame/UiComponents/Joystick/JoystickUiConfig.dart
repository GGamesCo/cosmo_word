import 'package:flame/game.dart';

class JoystickUiConfig{
  // Joystick size
  late Vector2 size;

  late Map<int, List<JoystickBtnUiConfig>> configs;

  JoystickUiConfig(double sideLength){
    size = Vector2(sideLength, sideLength);

    configs = Map<int, List<JoystickBtnUiConfig>>();
    configs[3] = [
      JoystickBtnUiConfig(Vector2(size.x * .25, size.y * .25), Vector2(size.x * .3, size.y * .6)),
      JoystickBtnUiConfig(Vector2(size.x * .25, size.y * .25), Vector2(size.x * .5, size.y * .3)),
      JoystickBtnUiConfig(Vector2(size.x * .25, size.y * .25), Vector2(size.x * .7, size.y * .6))
    ];
    configs[4] = [
      JoystickBtnUiConfig(Vector2(size.x * .23, size.y * .23), Vector2(size.x * .25, size.y * .5)),
      JoystickBtnUiConfig(Vector2(size.x * .23, size.y * .23), Vector2(size.x * .5, size.y * .25)),
      JoystickBtnUiConfig(Vector2(size.x * .23, size.y * .23), Vector2(size.x * .75, size.y * .5)),
      JoystickBtnUiConfig(Vector2(size.x * .23, size.y * .23), Vector2(size.x * .5, size.y * .75)),
    ];
    configs[5] = [
      JoystickBtnUiConfig(Vector2(size.x * .21, size.y * .21), Vector2(size.x * .25, size.y * .45)),
      JoystickBtnUiConfig(Vector2(size.x * .21, size.y * .21), Vector2(size.x * .5, size.y * .25)),
      JoystickBtnUiConfig(Vector2(size.x * .21, size.y * .21), Vector2(size.x * .75, size.y * .45)),
      JoystickBtnUiConfig(Vector2(size.x * .21, size.y * .21), Vector2(size.x * .65, size.y * .7)),
      JoystickBtnUiConfig(Vector2(size.x * .21, size.y * .21), Vector2(size.x * .35, size.y * .7)),
    ];
  }
}

class JoystickBtnUiConfig{
  Vector2 size;
  Vector2 position;

  JoystickBtnUiConfig(this.size, this.position);
}