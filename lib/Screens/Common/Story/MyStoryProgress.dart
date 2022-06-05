import 'package:flutter/material.dart';

class MyStoryProgress extends StatelessWidget {

  final double requiredWidth;
  final double requiredHeight;
  final int progressCurrent;
  final int progressTotal;

  MyStoryProgress({
    required this.requiredWidth,
    required this.requiredHeight,
    required this.progressCurrent,
    required this.progressTotal
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: requiredWidth,
      height: requiredHeight,
      child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
              child: Center(
                child: LinearProgressIndicator(
                  value: progressCurrent/progressTotal,
                  minHeight: 30,
                  backgroundColor: Color.fromRGBO(116, 126, 126, 1),
                  color: Color.fromRGBO(255, 207, 123, 1),
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
            Center(
              child: Text(
                "${progressCurrent}/${progressTotal}",
                style: TextStyle(
                  color: Color.fromRGBO(209, 129, 30, 1),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Positioned(
              top: 22,
              right: -1,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                        height: 40,
                        child: Image.asset('assets/images/common_controls/chest.png')
                    ),
                    Center(
                        child: Text(
                          "04:33",
                          style: TextStyle(
                            color: Color.fromRGBO(116, 126, 126, 1),
                            fontSize: 15,
                            fontFamily: 'Roboto',
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }
}