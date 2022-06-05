import 'dart:math';

import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:flame/components.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class StubInputDisplayController implements InputDisplayController{
  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  late PreviewZoneComponent previewZone;

  @override
  late Component rootUiControl;

  StubInputDisplayController({required this.userInputReceivedEvent}){
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
  void init() {
    var rectangle = RectangleComponent();


    var joystick = WordJoystickComponent(
        alph: ['U', 'D', 'O', 'C', 'L'], // Array must be of size 3 - 5 'C', 'L'
        userInputCompletedEvent: userInputReceivedEvent,
        sideLength: 250
    );

    previewZone = PreviewZoneComponent();
    previewZone.position = Vector2(0, 470);

    joystick.symbolInputAddedEvent.subscribe((eventArgs) {
      print("onSymbolAdded: " + eventArgs!.lastInputSymbol);
      previewZone.onSymbolAdded(eventArgs!);
    });

    rectangle.add(previewZone);
    rectangle.add(joystick);

    rectangle.position = Vector2(0, 0);

    rootUiControl = rectangle;
  }
}