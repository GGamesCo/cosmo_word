import 'package:cosmo_word/Flame/UiComponents/InputDisplayZone/BtnComponent.dart';
import 'package:cosmo_word/Flame/UiComponents/InputDisplayZone/HintBtnComponent.dart';
import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/PopupManager.dart';
import 'package:cosmo_word/di.dart';
import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import '../ElementsLayoutBuilder.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';

class SeparateBricksInputDisplayController implements InputDisplayController {
  final Event requestPauseGame = Event();
  final Event requestResumeGame = Event();

  final ElementLayoutData previewLayoutData;
  final ElementLayoutData joystickLayoutData;
  final ElementLayoutData rotateBtnLayoutData;
  final ElementLayoutData hintBtnLayoutData;
  final IWordInputController wordInputController;
  late IBalanceController balanceController;

  final FlameGame game;
  final int wordSize;

  late IWordRepository wordRepository;
  late PreviewZoneComponent previewZone;
  late RoundBtnComponent shuffleBtnComponent;
  late HintBtnComponent hintBtnComponent;

  WordJoystickComponent? wordJoystickComponent = null;

  @override
  late Component rootUiControl;

  SeparateBricksInputDisplayController({
    required this.previewLayoutData,
    required this.joystickLayoutData,
    required this.rotateBtnLayoutData,
    required this.hintBtnLayoutData,
    required this.wordInputController,
    required this.game,
    required this.wordSize
  }){
    wordRepository = getIt.get<IWordRepository>();
    balanceController = getIt.get<IBalanceController>();
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

    shuffleBtnComponent = RoundBtnComponent(spriteName: 'widget/shakeBtn.png')
    ..size = rotateBtnLayoutData.size
    ..anchor = rotateBtnLayoutData.anchor
    ..position = rotateBtnLayoutData.position;

    rectangle.add(shuffleBtnComponent);
    shuffleBtnComponent.tap.subscribe(onShuffleBtnClicked);

    hintBtnComponent = HintBtnComponent(spriteName: 'widget/hintBtn.png')
      ..size = hintBtnLayoutData.size
      ..anchor = hintBtnLayoutData.anchor
      ..position = hintBtnLayoutData.position;

    rectangle.add(hintBtnComponent);
    hintBtnComponent.tap.subscribe(onHintBtnClicked);

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

  bool hintingInProgress = false;
  void onHintBtnClicked(EventArgs? _) async{
    if (hintingInProgress){
      print("Hint in progress. Click ignored.");
      return;
    }

    hintingInProgress = true;
    if (await balanceController.isEnoughAsync(PriceListConfig.HINT_PRICE)){
      var hintWord = await wordInputController.getHintAsync();
      await wordJoystickComponent!.autoSelectAsync(hintWord);
      await balanceController.spendBalanceAsync(PriceListConfig.HINT_PRICE);
    }else{
      await PopupManager.NotEnoughMoneyPopup();
    }

    hintingInProgress = false;
  }
}