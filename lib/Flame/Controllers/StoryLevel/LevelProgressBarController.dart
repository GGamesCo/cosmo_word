import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/GameBL/Story/StoryLevelConfig.dart';
import '../../ElementsLayoutBuilder.dart';
import '../../UiComponents/Story/StoryLevelProgressBarUiControl.dart';

class LevelProgressBarController implements UiControllerBase{

  final ElementLayoutData layoutData;
  final StoryLevelConfig levelConfig;

  late StoryLevelProgressBarUiControl rootUiControl;

  LevelProgressBarController({
    required this.layoutData,
    required this.levelConfig
  });

  @override
  Future initAsync() async {
    rootUiControl = StoryLevelProgressBarUiControl(
      requiredWidth: layoutData.size.x,
      levelNumber: levelConfig.levelNumber
    );

    await rootUiControl.loaded;
    rootUiControl.position = layoutData.position;
    rootUiControl.anchor = layoutData.anchor;
    rootUiControl.setProgress(0);
  }

  void setProgress(double p){
    rootUiControl.setProgress(p);
  }

}