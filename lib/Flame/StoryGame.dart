import 'dart:math';
import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IFlowRepository.dart';
import 'package:cosmo_word/GameBL/Common/Models/InputAcceptedEventArgs.dart';
import 'package:cosmo_word/GameBL/UserStateController.dart';
import 'package:cosmo_word/Flame/ElementsLayoutBuilder.dart';
import 'package:cosmo_word/Flame/Models/GameUiElement.dart';
import 'package:cosmo_word/di.dart';
import 'package:flame/game.dart';
import '../GameBL/Common/Abstract/IWordInputController.dart';
import '../GameBL/Services/StoryLevelsService/StoryLevelsService.dart';
import '../GameBL/Services/StoryLocationsService/StoryLocationsService.dart';
import '../GameBL/Services/UserStateService/UserStateModel.dart';
import '../GameBL/Story/LevelProgressBarState.dart';
import 'Controllers/Abstract/BackgroundController.dart';
import 'Controllers/Abstract/InputDisplayController.dart';
import 'Controllers/CompletedWordsZoneController.dart';
import 'Controllers/InputWordParticlesController.dart';
import 'Controllers/StaticBackgroundController.dart';
import 'Controllers/StoryLevel/LevelProgressBarController.dart';
import 'Controllers/SeparateBricksInputDisplayController.dart';
import 'Models/CompletedBrickData.dart';
import 'Models/GameTypes.dart';
import 'UiComponents/ResultOverlay/ResultOverlayUiControl.dart';

class StoryGame extends FlameGame with HasTappables, HasDraggables {

  final UserStateController storyStateController;
  final IWordInputController wordInputController;
  final StoryLevelsService levelsService;
  final StoryLocationsService locationsService;
  final IFlowRepository flowRepository;
  final SoundsController soundsController;
  late GameElementsLayout _layoutData;

  late UserStateModel _storyState;

  late BackgroundController _backgroundController;
  late InputDisplayController _inputDisplayController;
  late CompletedWordsZoneController _completedWordsZoneController;
  late LevelProgressBarController _levelProgressBarController;
  late InputWordParticlesController _inputWordParticlesController;

  List<String> _colorCodes = ['y', 'g', 'r'];
  Random _random = new Random();

  StoryGame({
    required this.flowRepository,
    required this.storyStateController,
    required this.wordInputController,
    required this.levelsService,
    required this.locationsService,
    required this.soundsController
  });

  // Uncomment to see components outlines
  // @override
  // bool debugMode = true;

  @override
  Future<void> onLoad() async {
    var layoutBuilder = ElementsLayoutBuilder(screenWidth: this.size.x, screenHeight: this.size.y);
    _layoutData = layoutBuilder.calculateElementsLayout(GameType.StoryGame);

    _storyState = await storyStateController.getStoryState();
    var level = await levelsService.getLevelConfigById(_storyState.currentLevelId);
    final flow = await flowRepository.getFlowByIdAsync(level.flowId);
    await wordInputController.initializeAsync(flow);

    var location = await locationsService.getLocationConfigByLevelId(level.levelId);

    _backgroundController = StaticBackgroundController(bgImageFile: location.backgroundFileName);

    await _backgroundController.initAsync();

    _inputDisplayController = SeparateBricksInputDisplayController(
      previewLayoutData: _layoutData.elementsData[GameUiElement.Preview]!,
      joystickLayoutData: _layoutData.elementsData[GameUiElement.Joystick]!,
      rotateBtnLayoutData: _layoutData.elementsData[GameUiElement.RotateBtn]!,
      hintBtnLayoutData: _layoutData.elementsData[GameUiElement.HintBtn]!,
      storeBtnLayoutData: _layoutData.elementsData[GameUiElement.StoreBtn]!,
      adsBtnLayoutData: _layoutData.elementsData[GameUiElement.AdsBtn]!,
      wordInputController: wordInputController,
      analyticsController: getIt.get<AnalyticsController>(),
      game: this,
      wordSize: 3
    );
    
     await _inputDisplayController.initAsync();

    _completedWordsZoneController = CompletedWordsZoneController(
        layoutData: _layoutData.elementsData[GameUiElement.CompletedWordsZone]!,
        requiredBrickHeight: 40,
        initialScrollOffset: 0,
        fullContainerHeight: 1800,
        containerScrollThreshold: 0.8,
        containerScrollBricksCount: 6,
        brickFallDuration: 1.5,
        scrollAnimDurationSec: 1
    );
    await _completedWordsZoneController.initAsync();

    _levelProgressBarController = LevelProgressBarController(
        layoutData: _layoutData.elementsData[GameUiElement.LevelProgressBar]!,
        barState: getLevelProgressBarState()
    );
    await _levelProgressBarController.initAsync();

    _inputWordParticlesController = InputWordParticlesController(
        layoutData: _layoutData.elementsData[GameUiElement.InputWordParticles]!,
        directionVector: Vector2(-1, -1),
        particlesCount: 15,
        particleSize: Vector2(20, 20),
        durationSec: 1,
        wordAxisDistributionFactor: 100
    );
    await _inputWordParticlesController.initAsync();

    wordInputController.onInputAccepted.subscribe((userInput) {
      handleInputCompleted(userInput!);
    });

    wordInputController.onInputRejected.subscribe((args) {
      handleInputRejected();
    });

    add(_backgroundController.rootUiControl);
    add(_inputDisplayController.rootUiControl);
    add(_completedWordsZoneController.rootUiControl);
    add(_inputWordParticlesController.rootUiControl);
    add(_levelProgressBarController.rootUiControl);

    _levelProgressBarController.rootUiControl.loaded.then((value) {
      _levelProgressBarController.setProgressAnimated(getLevelProgressBarState());
    });
  }

  Future<void> handleInputCompleted(InputAcceptedEventArgs inputAcceptedEventArgs) async {
    var pickedColor = _pickRandomListElement(_colorCodes);
    add(ResultOverlayUiControl(isSuccess: true));
    _inputWordParticlesController.showParticles(inputAcceptedEventArgs.acceptedWord.length);
    await Future.wait([
      _completedWordsZoneController.renderNewBrick(CompletedBrickData(word: inputAcceptedEventArgs.acceptedWord, colorCode: pickedColor)),
      _levelProgressBarController.setProgressAnimated(getLevelProgressBarState())
    ]);

    if(inputAcceptedEventArgs.flowState.totalWordsInFlow == inputAcceptedEventArgs.flowState.completedWordsInFlow){
      storyStateController.processLevelCompleted();
    }
  }

  Future<void> handleInputRejected() async {
    add(ResultOverlayUiControl(isSuccess: false));
  }

  LevelProgressBarState getLevelProgressBarState(){
    return new LevelProgressBarState(
        currentValue: wordInputController.flowState.completedWordsInFlow,
        targetValue: wordInputController.flowState.totalWordsInFlow,
        levelNumber: _storyState.currentLevelId
    );
  }

  String _pickRandomListElement(List<String> list){
    var index = _random.nextInt(list.length);
    var element = list[index];
    return element;
  }
}