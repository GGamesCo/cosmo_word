import 'dart:async';

import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
import 'package:cosmo_word/GameBL/Story/LevelProgressBarState.dart';
import '../../ElementsLayoutBuilder.dart';
import '../../UiComponents/Story/StoryLevelProgressBarUiControl.dart';

class LevelProgressBarController implements UiControllerBase{

  final ElementLayoutData layoutData;
  final LevelProgressBarState barState;

  late StoryLevelProgressBarUiControl rootUiControl;

  LevelProgressBarController({
    required this.layoutData,
    required this.barState
  });

  @override
  Future initAsync() async {
    var bar = StoryLevelProgressBarUiControl(
      requiredWidth: layoutData.size.x,
      levelNumber: barState.levelNumber
    );

    bar.position = layoutData.position;
    bar.anchor = layoutData.anchor;
    rootUiControl = bar;

    return Completer().completeAndReturnFuture();
  }

  void setProgress(LevelProgressBarState barState){
    var p = barState.currentValue/barState.targetValue;
    rootUiControl.setProgress(p);
  }

}