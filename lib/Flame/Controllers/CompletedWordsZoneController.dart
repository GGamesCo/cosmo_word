import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:flame/components.dart';
import 'package:flame/src/components/component.dart';

import '../Models/CompletedBrickData.dart';
import '../UiComponents/CompletedWordsZone/CompletedWordsZoneUiControl.dart';
import 'StubGame/SimpleAnimatedBrick.dart';

class CompletedWordsZoneController extends UiControllerBase{

  final Vector2 viewportSize;
  final Vector2 viewportPosition;
  final Vector2 containerSize;
  final Vector2 containerPosition;
  final int brickSizeFactor;

  late CompletedWordsZoneUiControl rootUiControl;
  int _currentBrickPriority = 1000;

  CompletedWordsZoneController({
    required this.viewportSize,
    required this.viewportPosition,
    required this.containerSize,
    required this.containerPosition,
    required this.brickSizeFactor
  });

  @override
  Future<void> init() async {
    rootUiControl = CompletedWordsZoneUiControl(
        viewportSize: viewportSize,
        viewportPosition: viewportPosition,
        containerSize: containerSize,
        containerPosition: containerPosition,
        brickSizeFactor: brickSizeFactor
    );
  }

  void renderNewBrick(CompletedBrickData newBrickData){
    var brickInstance = SimpleAnimatedBrick(
        word: newBrickData.word,
        colorCode: newBrickData.colorCode,
        sizeFactor: this.brickSizeFactor
    );
    brickInstance.init();
    brickInstance.uiElement.priority = _currentBrickPriority--;

    rootUiControl.attachNewBrick(brickInstance.uiElement);
  }

  @override
  void onDispose() {

  }

}