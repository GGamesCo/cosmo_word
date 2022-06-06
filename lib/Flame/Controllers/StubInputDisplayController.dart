import 'dart:math';

import 'package:cosmo_word/Flame/UiComponents/Previewer/PreviewZoneComponent.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class StubInputDisplayController implements InputDisplayController{
  final Event<InputCompletedEventArgs> userInputReceivedEvent;
  final FlameGame game;

  late PreviewZoneComponent previewZone;

  @override
  late Component rootUiControl;

  StubInputDisplayController({required this.userInputReceivedEvent, required this.game}){
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
    var container = PositionComponent();
    container.size = Vector2(game.size.x, 305);
    container.position = Vector2(0, 450);

    var joystick = WordJoystickComponent(
        alph: ['U', 'D', 'O', 'C', 'L'], // Array must be of size 3 - 5 'C', 'L'
        userInputCompletedEvent: userInputReceivedEvent,
        sideLength: 200
    );

    previewZone = PreviewZoneComponent();
    previewZone.position = Vector2(0, 430);

    joystick.symbolInputAddedEvent.subscribe((eventArgs) {
      print("onSymbolAdded: " + eventArgs!.lastInputSymbol);
      previewZone.onSymbolAdded(eventArgs!);
    });

    container.add(previewZone);
    container.add(joystick);

    container.position = Vector2(0, 0);

    rootUiControl = container;
  }
}