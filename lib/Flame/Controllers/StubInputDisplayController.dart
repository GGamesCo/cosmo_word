import 'package:flame/components.dart';
import '../Models/Events/InputCompletedEventArgs.dart';
import 'Abstract/InputDisplayController.dart';
import '../UiComponents/Joystick/WordJoystickComponent.dart';
import 'package:event/event.dart';

class StubInputDisplayController implements InputDisplayController {
  final Event<InputCompletedEventArgs> userInputReceivedEvent;

  @override
  late Component rootUiControl;

  StubInputDisplayController({required this.userInputReceivedEvent}){
    var rectangle = RectangleComponent();

    rectangle.add(WordJoystickComponent(
      alph: ['U', 'D', 'O', 'C', 'L'], // Array must be of size 3 - 5 'C', 'L'
      userInputEvent: userInputReceivedEvent,
      sideLength: 200
    ));
    // rectangle.add(InputDisplayZoneGlass());
    // rectangle.add(InputDisplayZoneCover());

    rectangle.position = Vector2(0, 0);

    rootUiControl = rectangle;
  }

  @override
  void init() {

  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {

  }
}