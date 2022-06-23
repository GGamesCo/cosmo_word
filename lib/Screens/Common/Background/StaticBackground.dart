import 'package:flutter/material.dart';

class StaticBackground extends StatefulWidget {
  final String fileName;

  StaticBackground({required this.fileName});

  @override
  _StaticBackground createState() => _StaticBackground();
}

class _StaticBackground extends State<StaticBackground> with TickerProviderStateMixin {

  late Animation<Offset> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.4, 0)).animate(animationController);
    WidgetsBinding.instance
        .addPostFrameCallback((_) { animationController.repeat(reverse: true);});
  }

  @override
  Widget build(BuildContext context){
    return SlideTransition(
      position: animation,
      child: Container(
          child: new OverflowBox(
              minWidth: 0.0,
              minHeight: 0.0,
              maxWidth: double.infinity,
              child: new Image(
                  image: new AssetImage('assets/images/backgrounds/${widget.fileName}'),
                  fit: BoxFit.cover)
          )
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}