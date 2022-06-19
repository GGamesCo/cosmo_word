import 'package:flame/components.dart';
import 'Models/GameTypes.dart';
import 'Models/GameUiElement.dart';

class ElementsLayoutBuilder {
  final double screenWidth;
  final double screenHeight;

  final double _inputZonePart = 0.4;
  final double _levelProgressBarHeightDimension = 0.55;

  late GameElementsLayout _layout;
  late double _topPartAvailableHeight;

  ElementsLayoutBuilder({required this.screenWidth, required this.screenHeight});

  GameElementsLayout calculateElementsLayout(GameType gameType){

    _layout = GameElementsLayout();

    _topPartAvailableHeight = screenHeight * (1-_inputZonePart);
    _calculatePreviewAndJoystick();
    _calculateCompletedWordsZone(gameType);
    _calculateLevelProgressBar();
    _calculateRocket(_layout.elementsData[GameUiElement.CompletedWordsZone]!.size.x);

    return _layout;
  }

  void _calculatePreviewAndJoystick(){
    var bottomPartAvailableHeight = screenHeight - _topPartAvailableHeight;

    //size dimensions taken from photoshop
    var inputZoneRelativeHeight = 2680/(2680+11050);
    var inputZoneRealHeight = bottomPartAvailableHeight * inputZoneRelativeHeight;

    var inputZoneData = ElementLayoutData(
        size: Vector2(screenWidth, inputZoneRealHeight),
        anchor: Anchor.topLeft,
        position: Vector2(0, _topPartAvailableHeight)
    );
    _layout.pushNewElement(GameUiElement.Preview, inputZoneData);

    var joystickRealHeight = bottomPartAvailableHeight * (1-inputZoneRelativeHeight);

    var joystickData = ElementLayoutData(
        size: Vector2(joystickRealHeight, joystickRealHeight),
        anchor: Anchor.center,
        position: Vector2(screenWidth/2, _topPartAvailableHeight+inputZoneRealHeight+joystickRealHeight/2)
    );
    _layout.pushNewElement(GameUiElement.Joystick, joystickData);

    // Layout for Shuffle button
    var shuffleBtnWidth = bottomPartAvailableHeight*.2;
    var rotateBtnData = ElementLayoutData(
        size: Vector2(shuffleBtnWidth,shuffleBtnWidth),
        anchor: Anchor.center,
        position: Vector2(screenWidth-(shuffleBtnWidth/1.5), _topPartAvailableHeight + inputZoneRealHeight + shuffleBtnWidth/5));
    _layout.pushNewElement(GameUiElement.RotateBtn, rotateBtnData);
  }

  void _calculateCompletedWordsZone(GameType gameType){

    var zoneWidth = screenWidth;
    if(gameType == GameType.TimeChallengeGame){
      //dimension taken from photoshop
      var widthDimension = 11900/16250;
      zoneWidth = screenWidth * widthDimension;
    }

    var completedZoneData = ElementLayoutData(
        size: Vector2(zoneWidth, _topPartAvailableHeight),
        anchor: Anchor.bottomLeft,
        position: Vector2(0, 0)
    );
    _layout.pushNewElement(GameUiElement.CompletedWordsZone, completedZoneData);
  }

  void _calculateLevelProgressBar(){
    var levelProgressBarHeight = _topPartAvailableHeight * _levelProgressBarHeightDimension;
    //taken from photoshop
    var widthToHeightDimension = 3000/12500;
    var barSize = Vector2(levelProgressBarHeight*widthToHeightDimension, levelProgressBarHeight);
    var levelProgressBarData = ElementLayoutData(
        size: barSize,
        anchor: Anchor.topLeft,
        position: Vector2(0, _topPartAvailableHeight/2 - barSize.y/2)
    );
    _layout.pushNewElement(GameUiElement.LevelProgressBar, levelProgressBarData);
  }

  void _calculateRocket(double completedWordsZoneWidth){
    //dimension from ps
    var widthToHeightDimension = 350/1250;
    var height = _topPartAvailableHeight*0.75;
    var width = height * widthToHeightDimension;

    var rocketZoneData = ElementLayoutData(
        size: Vector2(width, height),
        anchor: Anchor.bottomRight,
        position: Vector2(screenWidth, _topPartAvailableHeight)
    );
    _layout.pushNewElement(GameUiElement.Rocket, rocketZoneData);
  }
}

class GameElementsLayout {
  final Map<GameUiElement, ElementLayoutData> elementsData = {};

  void pushNewElement(GameUiElement key, ElementLayoutData layoutData){
    elementsData[key] = layoutData;
  }
}

class ElementLayoutData {
  final Vector2 size;
  final Vector2 position;
  final Anchor anchor;

  ElementLayoutData({required this.size, required this.anchor, required this.position});
}