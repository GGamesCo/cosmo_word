import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:flame/components.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/ChallengeZoneController.dart';
import 'Abstract/InputDisplayController.dart';
import 'Abstract/UiControllerBase.dart';
import 'Abstract/UserInputController.dart';

class GameScreenController implements UiControllerBase {

  final ChallengeZoneController challengeController;
  final InputDisplayController inputDisplayController;

  @override
  late Component rootUiControl;

  GameScreenController({
      required this.challengeController,
      required this.inputDisplayController
  }){
    rootUiControl = Scene();
  }

  @override
  Future<void> init() async {
    challengeController.init();
    inputDisplayController.init();

    rootUiControl.add(challengeController.rootUiControl);
    rootUiControl.add(inputDisplayController.rootUiControl);
  }

  @override
  Future<void> onStart() async {

  }

  void onNewWordInput(InputCompletedEventArgs? wordInput) async {
    await Future.wait([
      challengeController.handleInputCompleted(wordInput),
      inputDisplayController.handleInputCompleted(wordInput)
    ]);
  }

  @override
  void onDispose(){
  }
}