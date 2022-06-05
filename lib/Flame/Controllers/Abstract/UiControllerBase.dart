import 'package:flame/components.dart';

abstract class UiControllerBase {
  Component get rootUiControl;

  void init();
}