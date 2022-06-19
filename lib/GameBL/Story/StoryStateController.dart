import 'package:cosmo_word/GameBL/Story/LevelProgressBarState.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';
import '../../Screens/GameScreen/Layers/Popups/PopupManager.dart';
import '../Common/Abstract/IFlowRepository.dart';
import '../Common/Abstract/IWordInputController.dart';
import '../Common/Models/WordFlowState.dart';
import '../Services/StoryLevelsService/StoryLevelsService.dart';
import '../Services/StoryStateService/StoryStateModel.dart';
import '../Services/StoryStateService/StoryStateService.dart';
import 'StoryLevelCompleteResult.dart';

@singleton
class StoryStateController {
  final StoryStateService storyStateService;
  final StoryLevelsService levelsService;
  final IFlowRepository flowRepository;
  final IWordInputController wordInputController;

  late StoryStateModel _storyState;

  final Event<Value<WordFlowState>> onFlowStateUpdated = Event<Value<WordFlowState>>();

  StoryStateController({
    required this.storyStateService,
    required this.levelsService,
    required this.flowRepository,
    required this.wordInputController
  });

  Future initAsync() async {
    _storyState = await storyStateService.getStoryState();
    var level = await levelsService.getLevelConfigById(_storyState.currentLevelId);

    wordInputController.initializeAsync(level.flowId);
    wordInputController.onFlowCompleted.subscribe((args) {
      handleFlowCompleted();
    });
  }

  void handleFlowCompleted() async {
    var completedLevel = await levelsService.getLevelConfigById(_storyState.currentLevelId);
    _storyState = await storyStateService.updateStoryProgress(
      StoryStateModel(
        storyLevelsIdList: _storyState.storyLevelsIdList,
        currentLevelId: _storyState.currentLevelId + 1
      )
    );

    var level = await levelsService.getLevelConfigById(_storyState.currentLevelId);
    wordInputController.initializeAsync(level.flowId);

    await PopupManager.ShowLevelCompletePopup(StoryLevelCompleteResult(
      levelNumber: _storyState.currentLevelNumber,
      coinReward: completedLevel.coinReward
    ));
  }

  LevelProgressBarState getLevelProgressBarState(){
    return new LevelProgressBarState(
        currentValue: wordInputController.flowState.completedWordsInFlow,
        targetValue: wordInputController.flowState.totalWordsInFlow,
        levelNumber: _storyState.currentLevelNumber
    );
  }

  Future<StoryStateModel> getStoryState(){
    return storyStateService.getStoryState();
  }
}