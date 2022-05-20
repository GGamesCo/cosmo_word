
import 'package:flame/components.dart';
import 'package:cosmo_word/Models/Events/InputCompletedEventArgs.dart';
import 'package:cosmo_word/UiComponents/StubGame/DisplayZone.dart';

import '../Abstract/InputDisplayController.dart';

class StubInputDisplayController implements InputDisplayController {
  @override
  late Component rootUiControl;

  StubInputDisplayController(){
    rootUiControl = DisplayZone();
  }

  @override
  Future<void> init() async {

  }

  @override
  Future<void> onStart() async {
  }

  @override
  Future<void> handleInputCompleted(InputCompletedEventArgs? wordInput) async {

  }

  @override
  void onDispose() {
  }
}