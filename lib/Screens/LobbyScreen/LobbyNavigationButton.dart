import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../TabletDetector.dart';
import '../../main.dart';

class LobbyNavigationButton extends StatefulWidget {

  final Function onTap;
  final String title1;
  final String title2;
  final Color fontColor;
  final String buttonIcon;
  final String buttonBg;

  const LobbyNavigationButton({
    Key? key,
    required this.onTap,
    required this.title1,
    required this.title2,
    required this.fontColor,
    required this.buttonIcon,
    required this.buttonBg,
  }) : super(key: key);

  @override
  State<LobbyNavigationButton> createState() => _LobbyNavigationButtonState();
}

class _LobbyNavigationButtonState extends State<LobbyNavigationButton> {

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {

    var fontSizeTop = !TabletDetector.isTablet() ? 30 : 55;
    var fontSizeBottom = !TabletDetector.isTablet() ? 12 : 25;

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
          child: IntrinsicHeight(
            child: Stack(
              children: [
                Image.asset(widget.buttonBg),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: !TabletDetector.isTablet() ? 45 : 80,
                        child: Image.asset(widget.buttonIcon)
                      ),
                      IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title1,
                              style: TextStyle(
                                color: widget.fontColor,
                                fontSize: fontSizeTop*1,
                                height: 1,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
                              widget.title2,
                              style: TextStyle(
                                color: widget.fontColor,
                                fontSize: fontSizeBottom*1,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ),
          )
      ),
    );
  }
}