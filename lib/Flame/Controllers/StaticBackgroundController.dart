import 'package:flame/components.dart';
import 'package:flame/src/components/component.dart';

import '../UiComponents/StubGame/DisplayZone.dart';
import 'Abstract/BackgroundController.dart';

class StaticBackgroundController implements BackgroundController {
  
  final String bgImageFile;

  @override
  late Component rootUiControl;

  @override
  Future<void> get uiComponentLoadedFuture => Future.wait([rootUiControl.loaded]);

  StaticBackgroundController({required this.bgImageFile});

  @override
  init() {
    rootUiControl = StaticBackgroundUiControl(bgFileName: bgImageFile);
  }

  @override
  void onDispose() {
  }
}