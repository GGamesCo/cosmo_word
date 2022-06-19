import 'package:event/event.dart';

class SymbolInputAddedEventArgs extends EventArgs {
  final String lastInputSymbol;
  final String inputString;

  SymbolInputAddedEventArgs({required this.lastInputSymbol, required this.inputString});
}