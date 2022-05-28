import 'package:cosmo_word/Flame/UiComponents/StubGame/InputDisplayZone/InputDisplayZoneGlass.dart';
import 'package:flame/components.dart';
import '../../Models/Events/InputCompletedEventArgs.dart';
import '../../UiComponents/StubGame/DisplayZone.dart';
import '../../UiComponents/StubGame/InputDisplayZone/InputDisplayZoneCover.dart';
import '../Abstract/InputDisplayController.dart';

class StubInputDisplayController implements InputDisplayController {
  @override
  late Component rootUiControl;

  StubInputDisplayController(){
    var rectangle = RectangleComponent();

    rectangle.add(InputDisplayZoneGlass());
    rectangle.add(InputDisplayZoneCover());

    rectangle.position = Vector2(0, 500);

    rootUiControl = rectangle;
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