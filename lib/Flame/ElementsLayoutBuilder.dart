import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'Models/GameTypes.dart';

class ElementsLayoutBuilder {
  final double screenWidth;
  final double screenHeight;

  final Map<String, double> psElementsHeights = {
    'inputDisplayZone': 2680,
    'joystick': 11050,
  };

  ElementsLayoutBuilder({required this.screenWidth, required this.screenHeight});

  GameElementsLayout calculateElementsLayout(GameType gameType){

    var layout = GameElementsLayout();

    var bottomPartAvailableHeight = screenHeight / 2;

    var inputZoneRelativeHeight = psElementsHeights['inputDisplayZone']!/(psElementsHeights['inputDisplayZone']!+psElementsHeights['joystick']!);
    var inputZoneRealHeight = bottomPartAvailableHeight * inputZoneRelativeHeight;

    var inputZoneData = ElementLayoutData(
        size: Vector2(screenWidth, inputZoneRealHeight),
        anchor: Anchor.topLeft,
        position: Vector2(0, screenHeight/2)
    );
    layout.pushNewElement('inputDisplayZone', inputZoneData);

    var joystickRealHeight = bottomPartAvailableHeight * (1-inputZoneRelativeHeight);

    var joystickData = ElementLayoutData(
        size: Vector2(joystickRealHeight, joystickRealHeight),
        anchor: Anchor.center,
        position: Vector2(screenWidth/2, bottomPartAvailableHeight+inputZoneRealHeight+joystickRealHeight/2)
    );
    layout.pushNewElement('joystick', joystickData);

    return layout;
  }
}

class GameElementsLayout {
  final Map<String, ElementLayoutData> elementsData = {};

  void pushNewElement(String key, ElementLayoutData layoutData){
    elementsData[key] = layoutData;
  }
}

class ElementLayoutData {
  final Vector2 size;
  final Vector2 position;
  final Anchor anchor;

  ElementLayoutData({required this.size, required this.anchor, required this.position});
}