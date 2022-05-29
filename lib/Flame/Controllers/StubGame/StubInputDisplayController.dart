import 'package:cosmo_word/Flame/UiComponents/StubGame/InputDisplayZone/InputDisplayZoneGlass.dart';
import 'package:flame/components.dart';
import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/StubGame/DisplayZone.dart';
import '../../UiComponents/StubGame/InputDisplayZone/InputDisplayZoneCover.dart';
import '../Abstract/InputDisplayController.dart';
import '../../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class StubInputDisplayController implements InputDisplayController {
  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  @override
  late Component rootUiControl;

  StubInputDisplayController({required this.userInputReceivedEvent}){
    var rectangle = RectangleComponent();

    rectangle.add(WordJoystickComponent(
      alph: ['U', 'D', 'O', 'C', 'L'], // Array must be of size 3 - 5 'C', 'L'
      userInputEvent: userInputReceivedEvent
    ));
    // rectangle.add(InputDisplayZoneGlass());
    // rectangle.add(InputDisplayZoneCover());

    rectangle.position = Vector2(0, 0);

    rootUiControl = rectangle;
  }

  @override
  Future<void> init() async {

  }

  @override
  Future<void> onStart() async {
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {

  }

  @override
  void onDispose() {
  }
}