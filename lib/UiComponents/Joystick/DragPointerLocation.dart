import 'package:event/event.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class SymbolPointerLocation extends EventArgs{
  String symbolId;
  Vector2 location;

  SymbolPointerLocation(this.symbolId, this.location);
}