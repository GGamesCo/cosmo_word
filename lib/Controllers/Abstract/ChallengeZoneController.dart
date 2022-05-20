import '../../Models/Events/InputCompletedEventArgs.dart';
import 'UiControllerBase.dart';

abstract class ChallengeZoneController implements UiControllerBase {
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput);
}