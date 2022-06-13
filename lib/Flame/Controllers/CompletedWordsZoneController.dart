import 'dart:async';

import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:flame/components.dart';
import '../ElementsLayoutBuilder.dart';
import '../Models/CompletedBrickData.dart';
import '../UiComponents/CompletedWordsZone/CompletedWordsZoneUiControl.dart';
import 'SimpleAnimatedBrick.dart';

class CompletedWordsZoneController extends UiControllerBase {

  final ElementLayoutData layoutData;
  final double requiredBrickHeight;
  final double initialScrollOffset;
  final double fullContainerHeight;
  final double containerScrollThreshold;
  final double containerScrollBricksCount;
  final double brickFallDuration;
  final double scrollAnimDurationSec;

  late Vector2 containerSize;
  late Vector2 containerPosition;

  late CompletedWordsZoneUiControl rootUiControl;
  int _currentBrickNumber = 0;
  double get _bricksStackHeight => _currentBrickNumber*requiredBrickHeight;

  CompletedWordsZoneController({
    required this.layoutData,
    required this.requiredBrickHeight,
    required this.initialScrollOffset,
    required this.fullContainerHeight,
    required this.containerScrollThreshold,
    required this.containerScrollBricksCount,
    required this.brickFallDuration,
    required this.scrollAnimDurationSec
  });

  @override
  Future initAsync() {
    rootUiControl = CompletedWordsZoneUiControl(
      viewportSize: layoutData.size,
      viewportPosition: layoutData.position,
      anchor: layoutData.anchor,
      bricksContainerHeight: fullContainerHeight,
      scrollOffset: initialScrollOffset
    );

    return Completer().completeAndReturnFuture();
  }

  void renderNewBrick(CompletedBrickData newBrickData){

    var normalizedSpawnHeight = fullContainerHeight > layoutData.size.y ? fullContainerHeight - layoutData.size.y - rootUiControl.scrollOffset : 0;

    var brickInstance = SimpleAnimatedBrick(
      word: newBrickData.word,
      colorCode: newBrickData.colorCode,
      requiredBrickHeight: requiredBrickHeight,
      spawnY: normalizedSpawnHeight*1,
      spawnX: layoutData.size.x/2,
      fallToY: fullContainerHeight - _bricksStackHeight - requiredBrickHeight,
      brickFallDuration: brickFallDuration
    );
    brickInstance.init();
    brickInstance.uiElement.priority = 1000 - _currentBrickNumber++;

    rootUiControl.attachNewBrick(brickInstance.uiElement);
    validateScrollOffset();
  }

  void validateScrollOffset(){
    var viewportHeight = layoutData.size.y;
    var alreadyFilledHeight = _bricksStackHeight - rootUiControl.scrollOffset;

    var filledPart = alreadyFilledHeight / viewportHeight;
    if(filledPart > containerScrollThreshold){
      rootUiControl.updateScrollOffset(requiredBrickHeight*containerScrollBricksCount, scrollAnimDurationSec);
    }
  }
}