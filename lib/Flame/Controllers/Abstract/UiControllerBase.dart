import 'package:flame/components.dart';

abstract class UiControllerBase {
  Component get rootUiControl;

  Future<void> init();
  void onDispose();
}