import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Flame/Common/SoundsController.dart';
import 'package:cosmo_word/Flame/UiComponents/InputDisplayZone/BtnComponent.dart';
import 'package:cosmo_word/Flame/UiComponents/InputDisplayZone/HintBtnComponent.dart';
import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IBalanceController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordInputController.dart';
import 'package:cosmo_word/GameBL/Common/Abstract/IWordRepository.dart';
import 'package:cosmo_word/GameBL/Common/StageManager.dart';
import 'package:cosmo_word/GameBL/Configs/PriceListConfig.dart';
import 'package:cosmo_word/Screens/GameScreen/Layers/Popups/PopupManager.dart';
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
  final ElementLayoutData hintBtnLayoutData;
  final ElementLayoutData storeBtnLayoutData;
  final ElementLayoutData adsBtnLayoutData;
  final IWordInputController wordInputController;
  final AnalyticsController analyticsController;
  late IBalanceController balanceController;

  final FlameGame game;
  final int wordSize;

  late IWordRepository wordRepository;
  late PreviewZoneComponent previewZone;
  late RoundBtnComponent shuffleBtnComponent;
  late HintBtnComponent hintBtnComponent;
  late RoundBtnComponent storeBtnComponent;
  late RoundBtnComponent adsBtnComponent;

  WordJoystickComponent? wordJoystickComponent = null;

  @override
  late Component rootUiControl;

  SeparateBricksInputDisplayController({
    required this.previewLayoutData,
    required this.joystickLayoutData,
    required this.rotateBtnLayoutData,
    required this.hintBtnLayoutData,
    required this.storeBtnLayoutData,
    required this.adsBtnLayoutData,
    required this.wordInputController,
    required this.analyticsController,
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

    // storeBtnComponent = RoundBtnComponent(spriteName: 'widget/storeBtn.png')
    //   ..size = storeBtnLayoutData.size
    //   ..anchor = storeBtnLayoutData.anchor
    //   ..position = storeBtnLayoutData.position;
    //
    // rectangle.add(storeBtnComponent);
    // storeBtnComponent.tap.subscribe(onStoreBtnClicked);

    // adsBtnComponent = RoundBtnComponent(spriteName: 'widget/watchAdBtn.png')
    //   ..size = adsBtnLayoutData.size
    //   ..anchor = adsBtnLayoutData.anchor
    //   ..position = adsBtnLayoutData.position;
    //
    // rectangle.add(adsBtnComponent);
    // adsBtnComponent.tap.subscribe(onAdsBtnClicked);

    rootUiControl = rectangle;

    var set = await wordRepository.getSetByIdAsync(wordInputController.flowState.setId);
    initJoystickUi(set);
  }

  Future handleJoystickEvent(InputCompletedEventArgs args) async {
    await wordInputController.tryAcceptWordAsync(args.inputString);
  }

  void initJoystickUi(WordSet wordSet) {
    var shuffledSet =  {...wordSet.chars}.toList();
    shuffledSet.shuffle();

    var joystick = WordJoystickComponent(
        alph: shuffledSet,
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
    analyticsController.logEventAsync(AnalyticEvents.SHUFFLE_CLICK, params: {"alph":wordJoystickComponent!.alph.join()});

    FlameAudio.play(SoundsController.SHUFFLE_JOYSTICK, volume: 0.5);
    wordJoystickComponent!.shuffle();
  }

  bool hintingInProgress = false;
  void onHintBtnClicked(EventArgs? _) async{
    if (hintingInProgress){
      print("Hint in progress. Click ignored.");
      return;
    }

    hintingInProgress = true;

    try{
      if (await balanceController.isEnoughAsync(PriceListConfig.HINT_PRICE)){
        analyticsController.logEventAsync(AnalyticEvents.HINT_CLICK, params: {"applied": true, "stage": getIt.get<StageManager>().currentStage.state.toString()});

        var hintWord = await wordInputController.getHintAsync();
        await wordJoystickComponent!.autoSelectAsync(hintWord);
        await balanceController.spendBalanceAsync(PriceListConfig.HINT_PRICE);
      }else{
        analyticsController.logEventAsync(AnalyticEvents.HINT_CLICK, params: {"applied": false, "stage": getIt.get<StageManager>().currentStage.state.toString()});

        FlameAudio.play("outOfCoins.wav");
        await PopupManager.NotEnoughMoneyPopup();
      }
    }catch(e){
      print("Hint error: ${e}");
    }
    finally{
      hintingInProgress = false;
    }
  }

  void onStoreBtnClicked(EventArgs? _) async {
    // TODO: Store btn click handler
  }

  void onAdsBtnClicked(EventArgs? _) async {
    // TODO: Ads btn click handler
  }
}