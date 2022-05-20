
import 'package:event/src/event.dart';
import 'package:flame/components.dart';
import 'package:cosmo_word/Models/Events/InputCompletedEventArgs.dart';
import 'package:cosmo_word/UiComponents/StubGame/DisplayZone.dart';
import 'package:cosmo_word/UiComponents/StubGame/JoystickZone.dart';
import '../Abstract/UserInputController.dart';

class StubUserInputController implements UserInputController {

  @override
  late bool isLocked = false;

  @override
  late Event<InputCompletedEventArgs> onInputCompleted;

  @override
  late Component rootUiControl;

  StubUserInputController(){
    rootUiControl = JoystickZone(tapCallback: tapCallback);
  }

  void tapCallback(){
    onInputCompleted.broadcast(InputCompletedEventArgs("Word"));
  }

  @override
  Future<void> init() async {
    onInputCompleted = Event();
  }

  @override
  Future<void> onStart() async {
  }

  @override
  void onDispose() {
  }
}