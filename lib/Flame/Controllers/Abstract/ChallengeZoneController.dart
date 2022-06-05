import '../../Models/Events/InputCompletedEventArgs.dart';
import 'UiControllerBase.dart';

abstract class ChallengeZoneController implements UiControllerBase {
  bool checkInputAcceptable(InputCompletedEventArgs wordInput);
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput);
}