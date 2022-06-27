import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:event/event.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:injectable/injectable.dart';
import '../../Screens/GameScreen/Layers/Popups/PopupManager.dart';
import '../Common/Abstract/IFlowRepository.dart';
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
  final IBalanceController balanceController;

  late StoryStateModel _storyState;

  final Event<Value<WordFlowState>> onFlowStateUpdated = Event<Value<WordFlowState>>();

  StoryStateController({
    required this.storyStateService,
    required this.levelsService,
    required this.flowRepository,
    required this.balanceController
  });

  Future initAsync() async {
    _storyState = await storyStateService.getStoryState();
  }

  void processLevelCompleted() async {
    var completedLevel = await levelsService.getLevelConfigById(_storyState.currentLevelId);
    _storyState = await storyStateService.updateStoryProgress(
      StoryStateModel(
        storyLevelsIdList: _storyState.storyLevelsIdList,
        currentLevelId: _storyState.currentLevelId + 1
      )
    );

    await balanceController.addBalanceAsync(completedLevel.coinReward);
    await PopupManager.ShowLevelCompletePopup(StoryLevelCompleteResult(
        levelNumber: _storyState.currentLevelNumber,
        coinReward: completedLevel.coinReward
    ));
  }

  Future<StoryStateModel> getStoryState(){
    return storyStateService.getStoryState();
  }
}