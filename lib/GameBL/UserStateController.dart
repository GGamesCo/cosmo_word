import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:event/event.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:injectable/injectable.dart';
import '../Screens/GameScreen/Layers/Popups/PopupManager.dart';
import 'Common/Abstract/IFlowRepository.dart';
import 'Common/Models/WordFlowState.dart';
import 'Services/StoryLevelsService/StoryLevelsService.dart';
import 'Services/UserStateService/UserStateModel.dart';
import 'Services/UserStateService/UserStateService.dart';
import 'Story/StoryLevelCompleteResult.dart';

@singleton
class UserStateController {
  final UserStateService userStateService;
  final StoryLevelsService levelsService;
  final IFlowRepository flowRepository;
  final IBalanceController balanceController;

  final Event<Value<WordFlowState>> onFlowStateUpdated = Event<Value<WordFlowState>>();

  UserStateController({
    required this.userStateService,
    required this.levelsService,
    required this.flowRepository,
    required this.balanceController
  });

  void processLevelCompleted() async {
    var storyState = await userStateService.getStoryState();
    var completedLevel = await levelsService.getLevelConfigById(storyState.currentLevelId);
    storyState = await userStateService.setStoryState(
      UserStateModel(
        storyLevelsIdList: storyState.storyLevelsIdList,
        currentLevelId: storyState.currentLevelId + 1
      )
    );

    await balanceController.addBalanceAsync(completedLevel.coinReward);
    await PopupManager.ShowLevelCompletePopup(StoryLevelCompleteResult(
        levelNumber: storyState.currentLevelNumber,
        coinReward: completedLevel.coinReward
    ));
  }

  Future<UserStateModel> getStoryState(){
    return userStateService.getStoryState();
  }

  Future<int> getRocketRecord(){
    return userStateService.getTimeChallengeRecord();
  }

  Future<void> setRocketRecord(int newRecord){
    return userStateService.setTimeChallengeRecord(newRecord);
  }
}