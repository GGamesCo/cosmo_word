import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class SymbolPointerLocationArgs extends EventArgs{
  String symbolId;
  Vector2 location;

  SymbolPointerLocationArgs(this.symbolId, this.location);
}