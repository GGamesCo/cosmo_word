import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyAppWidget extends StatelessWidget {
  final Widget child;
  MyAppWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return child;
  }
}