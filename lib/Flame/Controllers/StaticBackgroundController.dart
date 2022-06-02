import 'package:flame/components.dart';
import 'package:flame/src/components/component.dart';

import '../UiComponents/StubGame/DisplayZone.dart';
import 'Abstract/BackgroundController.dart';

class StaticBackgroundController implements BackgroundController {
  
  final String bgImageFile;

  @override
  late Component rootUiControl;
  
  StaticBackgroundController({required this.bgImageFile});

  @override
  Future<void> init() async {
    rootUiControl = StaticBackgroundUiControl(bgFileName: bgImageFile);
  }

  @override
  void onDispose() {
  }    
}