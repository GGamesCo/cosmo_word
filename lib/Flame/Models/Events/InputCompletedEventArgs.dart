import 'package:event/event.dart';

class InputCompletedEventArgs extends EventArgs{
  String inputString;

  InputCompletedEventArgs(this.inputString);
}