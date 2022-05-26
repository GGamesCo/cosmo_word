import '../../Models/Events/InputCompletedEventArgs.dart';
import 'UiControllerBase.dart';

abstract class InputDisplayController implements UiControllerBase {
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput);
}