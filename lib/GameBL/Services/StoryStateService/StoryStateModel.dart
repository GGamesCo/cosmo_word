class StoryStateModel {
  int get currentLevelNumber => storyLevelsIdList.indexOf(currentLevelId) + 1;
  int get nextMilestoneTargetLevel => storyLevelsIdList.indexOf(storyLevelsIdList.last);

  final List<int> storyLevelsIdList;
  final int currentLevelId;

  StoryStateModel({
    required this.storyLevelsIdList,
    required this.currentLevelId,
  });
}