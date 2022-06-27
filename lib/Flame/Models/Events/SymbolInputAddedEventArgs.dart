import 'package:event/event.dart';

class SymbolInputAddedEventArgs extends EventArgs {
  final int id;
  final String lastInputSymbol;
  final String inputString;

  SymbolInputAddedEventArgs({required this.id, required this.lastInputSymbol, required this.inputString});
}