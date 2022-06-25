import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class SymbolPointerLocationArgs extends EventArgs{
  int id;
  String symbol;
  Vector2 location;

  SymbolPointerLocationArgs({required this.id, required this.symbol, required this.location});
}