import 'package:cosmo_word/Flame/UiComponents/Scene.dart';
import 'package:flame/components.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/BackgroundController.dart';
import 'Abstract/ChallengeZoneController.dart';
import 'Abstract/InputDisplayController.dart';
import 'Abstract/UiControllerBase.dart';

class GameScreenController implements UiControllerBase {

  final BackgroundController backgroundController;
  final ChallengeZoneController challengeController;
  final InputDisplayController inputDisplayController;

  @override
  late Component rootUiControl;

  GameScreenController({
      required this.backgroundController,
      required this.challengeController,
      required this.inputDisplayController
  }){
    rootUiControl = Scene();
  }

  @override
  Future<void> init() async {
    backgroundController.init();
    challengeController.init();
    inputDisplayController.init();

    rootUiControl.add(backgroundController.rootUiControl);
    rootUiControl.add(challengeController.rootUiControl);
    rootUiControl.add(inputDisplayController.rootUiControl);
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