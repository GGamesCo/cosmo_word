import 'package:cosmo_word/Flame/UiComponents/InputDisplayZone/ShakeBtnComponent.dart';
import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/di.dart';
import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import '../ElementsLayoutBuilder.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';

class SeparateBricksInputDisplayController implements InputDisplayController {
  final ElementLayoutData previewLayoutData;
  final ElementLayoutData joystickLayoutData;
  final ElementLayoutData rotateBtnLayoutData;
  final IWordInputController wordInputController;

  final FlameGame game;
  final int wordSize;

  late IWordRepository wordRepository;
  late PreviewZoneComponent previewZone;
  late ShakeBtnComponent shuffleBtnComponent;

  WordJoystickComponent? wordJoystickComponent = null;

  @override
  late Component rootUiControl;

  SeparateBricksInputDisplayController({
    required this.previewLayoutData,
    required this.joystickLayoutData,
    required this.rotateBtnLayoutData,
    required this.wordInputController,
    required this.game,
    required this.wordSize
  }){
    wordRepository = getIt.get<IWordRepository>();
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    previewZone.onInputCompleted(wordInput!);
  }

  @override
  Future<void> handleInputRejected() async {
    previewZone.onInputRejected();
  }

  @override
  Future initAsync() async {
   	var rectangle = RectangleComponent();

    previewZone = PreviewZoneComponent(layoutData: previewLayoutData);

    wordInputController.onSetRefreshed.subscribe((args) => initJoystickUi(args!.value));
    wordInputController.onInputAccepted.subscribe((args) => handleInputCompleted(InputCompletedEventArgs(args!.acceptedWord)));
    wordInputController.onInputRejected.subscribe((args) => handleInputRejected());

    rectangle.add(previewZone);

    rectangle.position = Vector2(0, 0);

    shuffleBtnComponent = ShakeBtnComponent()
    ..size = rotateBtnLayoutData.size
    ..anchor = rotateBtnLayoutData.anchor
    ..position = rotateBtnLayoutData.position;

    rectangle.add(shuffleBtnComponent);
    shuffleBtnComponent.tap.subscribe(onShuffleBtnClicked);

    rootUiControl = rectangle;

    var set = await wordRepository.getSetByIdAsync(wordInputController.flowState.setId);
    initJoystickUi(set);
  }

  Future handleJoystickEvent(InputCompletedEventArgs args) async {
    await wordInputController.tryAcceptWordAsync(args.inputString);
  }

  void initJoystickUi(WordSet wordSet) {
    var joystick = WordJoystickComponent(
        alph: wordSet.chars,
        layoutData: joystickLayoutData
    );

    joystick.userInputCompletedEvent.subscribe((args) => handleJoystickEvent(args!));

    joystick.symbolInputAddedEvent.subscribe((eventArgs) {
      print("onSymbolAdded: " + eventArgs!.inputString);
      var countSymbols = eventArgs.inputString.length;
      print("SOUND: btn-press-${countSymbols}.mp3");
      FlameAudio.play('btn-press-${countSymbols}.mp3');
      previewZone.onSymbolAdded(eventArgs);
    });

    if (wordJoystickComponent != null){
      wordJoystickComponent!.onDispose();
      wordJoystickComponent!.removeFromParent();
    }
    wordJoystickComponent = joystick;

    rootUiControl.add(wordJoystickComponent!);
	}

  void onShuffleBtnClicked(EventArgs? _){
    wordJoystickComponent!.shuffle();
  }
}