import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/GameBL/Story/StoryLevelConfig.dart';
import 'package:flame/components.dart';

import '../../UiComponents/Story/StoryLevelProgressBarUiControl.dart';

class LevelProgressBarController implements UiControllerBase{

  final double width;
  final Vector2 position;
  final StoryLevelConfig levelConfig;

  late StoryLevelProgressBarUiControl rootUiControl;

  LevelProgressBarController({
    required this.width,
    required this.position,
    required this.levelConfig
  });

  @override
  void init() async {
    rootUiControl = StoryLevelProgressBarUiControl(
      requiredWidth: width,
      levelNumber: levelConfig.levelNumber
    );

    await rootUiControl.loaded;
    rootUiControl.position = Vector2(position.x, position.y);
    rootUiControl.setProgress(0);
  }

  void setProgress(double p){
    rootUiControl.setProgress(p);
  }

}