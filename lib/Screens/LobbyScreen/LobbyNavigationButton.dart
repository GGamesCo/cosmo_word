import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LobbyNavigationButton extends StatefulWidget {

  final String imageFileName;
  final Function onTap;

  const LobbyNavigationButton({ Key? key, required this.imageFileName, required this.onTap }) : super(key: key);

  @override
  State<LobbyNavigationButton> createState() => _LobbyNavigationButtonState();
}
//'assets/images/lobby/lobby-navigation-goto-mystory.png'
class _LobbyNavigationButtonState extends State<LobbyNavigationButton> {

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        HapticFeedback.vibrate();
        setState(() {_isPressed = true;});
        widget.onTap();
      },
      onTapUp: (e) {
        setState(() {_isPressed = false;});
      },
      child: RotationTransition(
          alignment: Alignment.center,
          turns: _isPressed ? new AlwaysStoppedAnimation(4 / 360) : new AlwaysStoppedAnimation(0),
          child: Image.asset(widget.imageFileName)
      ),
    );
  }
}