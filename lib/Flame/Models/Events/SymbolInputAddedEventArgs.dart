import 'package:event/event.dart';

class SymbolInputAddedEventArgs extends EventArgs{
  String lastInputSymbol;
  String inputString;

  SymbolInputAddedEventArgs(this.lastInputSymbol, this.inputString);
}