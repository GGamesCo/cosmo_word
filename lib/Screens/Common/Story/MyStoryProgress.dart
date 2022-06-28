import 'package:flutter/material.dart';

class MyStoryProgress extends StatelessWidget {

  final int progressCurrent;
  final int progressTotal;

  MyStoryProgress({
    required this.progressCurrent,
    required this.progressTotal
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
            Positioned.fill(
              child:Align(
                alignment: Alignment.centerRight,
                child: IntrinsicHeight(
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 40,
                            child: Image.asset('assets/images/common_controls/chest.png')
                        ),
                        SizedBox(height: 5),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}