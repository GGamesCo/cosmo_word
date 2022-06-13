import 'dart:async';

import 'package:cosmo_word/Flame/Utils/CompleterExtensions.dart';
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
  Future initAsync() {
    rootUiControl = StaticBackgroundUiControl(bgFileName: bgImageFile);
    return Completer().completeAndReturnFuture();
  }
}