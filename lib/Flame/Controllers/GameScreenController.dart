import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:flame/components.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/ChallengeZoneController.dart';
import 'Abstract/InputDisplayController.dart';
import 'Abstract/UiControllerBase.dart';
import 'Abstract/UserInputController.dart';

class GameScreenController implements UiControllerBase {

  final UserInputController userInputController;
  final ChallengeZoneController challengeController;
  final InputDisplayController inputDisplayController;

  @override
  late Component rootUiControl;

  GameScreenController({
      required this.userInputController,
      required this.challengeController,
      required this.inputDisplayController
  }){
    rootUiControl = Scene();
  }

  @override
  Future<void> init() async {
    userInputController.init();
    challengeController.init();
    inputDisplayController.init();

    rootUiControl.add(userInputController.rootUiControl);
    rootUiControl.add(challengeController.rootUiControl);
    rootUiControl.add(inputDisplayController.rootUiControl);

    userInputController.onInputCompleted + _onNewWordInput;
    userInputController.isLocked = false;
  }

  @override
  Future<void> onStart() async {

  }

  void _onNewWordInput(InputCompletedEventArgs? wordInput) async {
    userInputController.isLocked = true;
    await Future.wait([
      challengeController.handleInputCompleted(wordInput),
      inputDisplayController.handleInputCompleted(wordInput)
    ]);
    userInputController.isLocked = false;
  }

  @override
  void onDispose(){
    userInputController.onInputCompleted - _onNewWordInput;
  }
}