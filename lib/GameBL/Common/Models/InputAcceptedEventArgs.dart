import 'package:cosmo_word/GameBL/Common/Models/WordFlowState.dart';
import 'package:event/event.dart';

class InputAcceptedEventArgs extends EventArgs {
  final String acceptedWord;
  final WordFlowState flowState;

  InputAcceptedEventArgs({
    required this.acceptedWord,
    required this.flowState,
  });
}