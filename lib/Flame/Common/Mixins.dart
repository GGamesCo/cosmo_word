import 'package:event/event.dart';
import 'package:flame/game.dart';

import '../Models/Events/GameCompletedEventArgs.dart';

mixin HasGameCompletedEvent on FlameGame {
  final Event<GameCompletedEventArgs> gameCompletedEvent = Event<GameCompletedEventArgs>();
}