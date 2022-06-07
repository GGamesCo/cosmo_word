import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/GameBL/Story/StoryLevelConfig.dart';
import 'package:flame/src/components/component.dart';

import '../../UiComponents/Story/StoryLevelProgressBarUiControl.dart';

class LevelProgressBarController implements UiControllerBase{

  final StoryLevelConfig levelConfig;

  late Component rootUiControl;

  LevelProgressBarController({required this.levelConfig}){
    rootUiControl = StoryLevelProgressBarUiControl();
  }

  @override
  void init() {

  }

}