import 'package:flame/components.dart';
import 'package:flame/src/components/component.dart';
import '../UiComponents/Background/StaticBackgroundUiControl.dart';
import 'Abstract/BackgroundController.dart';

class StaticBackgroundController implements BackgroundController {
  
  final String bgImageFile;

  @override
  late Component rootUiControl;

  StaticBackgroundController({required this.bgImageFile});

  @override
  init() {
    rootUiControl = StaticBackgroundUiControl(bgFileName: bgImageFile);
  }
}