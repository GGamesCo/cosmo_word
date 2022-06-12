import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import '../ElementsLayoutBuilder.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class SeparateBricksInputDisplayController implements InputDisplayController {
  final ElementLayoutData previewLayoutData;
  final ElementLayoutData joystickLayoutData;
  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  late PreviewZoneComponent previewZone;

  @override
  late Component rootUiControl;

  SeparateBricksInputDisplayController({
    required this.previewLayoutData,
    required this.joystickLayoutData,
    required this.userInputReceivedEvent
  });
  
  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {
    previewZone.onInputCompleted(wordInput!);
  }

  @override
  Future<void> handleInputRejected() async {
    previewZone.onInputRejected();
  }

  @override
  void init() {
    var rectangle = RectangleComponent();

    var joystick = WordJoystickComponent(
        alph: ['U', 'D', 'O', 'C', 'L'], // Array must be of size 3 - 5 'C', 'L'
        userInputCompletedEvent: userInputReceivedEvent,
        layoutData: joystickLayoutData
    );

    previewZone = PreviewZoneComponent(layoutData: previewLayoutData);

    joystick.symbolInputAddedEvent.subscribe((eventArgs) {
      print("onSymbolAdded: " + eventArgs!.inputString);
      var countSymbols = eventArgs!.inputString.length;
      print("SOUND: btn-press-${countSymbols}.mp3");
      FlameAudio.play('btn-press-${countSymbols}.mp3');
      previewZone.onSymbolAdded(eventArgs!);
    });

    rectangle.add(previewZone);
    rectangle.add(joystick);

    rectangle.position = Vector2(0, 0);

    rootUiControl = rectangle;
  }
}