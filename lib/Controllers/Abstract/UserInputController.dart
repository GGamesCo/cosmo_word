import 'package:event/event.dart';
import '../../Models/Events/InputCompletedEventArgs.dart';
import 'UiControllerBase.dart';


abstract class UserInputController extends UiControllerBase {
  Event<InputCompletedEventArgs> get onInputCompleted;
  late bool isLocked;
}