import 'package:cosmo_word/GameBL/Story/LevelProgressBarState.dart';
import 'package:event/event.dart';
import 'package:injectable/injectable.dart';
import '../Common/Abstract/IFlowRepository.dart';
import '../Common/Abstract/IWordInputController.dart';
import '../Common/Models/WordFlowState.dart';
import '../Services/StoryLevelsService/StoryLevelsService.dart';
import '../Services/StoryStateService/StoryStateModel.dart';
import '../Services/StoryStateService/StoryStateService.dart';

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
    wordInputController.onInputAccepted.subscribe((args) {
      handleNewInput(args!.flowState);
    });
  }

  void handleNewInput(WordFlowState newFlowState) async {
    if(newFlowState.completedWordsInFlow == newFlowState.totalWordsInFlow){
      //show popup
    }
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

  Future<StoryStateModel> increaseLevel() async {
    var currentState = await getStoryState();
    var currentLevelIdIndex = currentState.storyLevelsIdList.indexOf(currentState.currentLevelId);

    var newState = StoryStateModel(
        storyLevelsIdList: currentState.storyLevelsIdList,
        currentLevelId: currentState.storyLevelsIdList[currentLevelIdIndex+1]
    );

    var updatedState = await storyStateService.updateStoryProgress(newState);
    return updatedState;
  }
}