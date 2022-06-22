import 'package:cosmo_word/Screens/Common/Story/MyStoryProgress.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Flame/StoryGame.dart';
import '../../../../GameBL/Common/Models/GameState.dart';
import '../../../../GameBL/Common/StageManager.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateModel.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateService.dart';
import '../../../../GameBL/Story/StoryStateController.dart';
import '../../../../di.dart';
import '../../../../main.dart';
import '../../GameScreen.dart';

class OutOfCoinsPopup extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 7 / 16,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset("assets/images/popups/popup-out-of_coins.png")),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment(0.5, 0.45),
                      child: AspectRatio(
                        aspectRatio: 12 / 16,
                        child: Container(
                          //color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            child: Container(
                              //color: Colors.blue,
                              child: Stack(
                                children: [
                                  Positioned(
                                        left: 70,
                                        top: 280,
                                        width: 150,
                                        height: 60,
                                        child:
                                    Container(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(color: Colors.orangeAccent, width: 4)
                                      // ),
                                      child: TextButton(
                                        style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                        ),
                                        onPressed: () {
                                          print("TODO: Add analytics on buy btn click");
                                        },
                                        child: Text(''),
                                      ),
                                    )
                                    ),
                                  Positioned(
                                      left: 0,
                                      top: 350,
                                      width: 290,
                                      height: 90,
                                      child:
                                      Container(
                                        // decoration: BoxDecoration(
                                        //     border: Border.all(color: Colors.orangeAccent, width: 4)
                                        // ),
                                        child: TextButton(
                                          style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(''),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle(){
    return IntrinsicHeight(
      child: Stack(
        children: [
        //  Image.asset("assets/images/popups/reward-bg.png"),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: SizedBox(height: 100, child: Image.asset("assets/images/popups/reward-coin.png"))
                ),
                Center(
                    child: Text(
                      "",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(131, 135, 125, 1),
                          fontSize: 50
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getTimeChallengeData(){

    var textStyle = TextStyle(
        fontFamily: 'Agency',
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(131, 135, 125, 1)
    );

    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset("assets/images/popups/time-challenge-bg.png"),
          Positioned.fill(
            child: Align(
              alignment: Alignment(0.5, 0.3),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("YOU REACHED ", style: textStyle),
                              Text("1000m", style: textStyle.copyWith(color: Color.fromRGBO(107, 160, 22, 1))),
                            ],
                          )
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("YOUR RECORD IS ", style: textStyle),
                              Text("1100m", style: textStyle.copyWith(color: Color.fromRGBO(107, 160, 22, 1))),
                            ],
                          )
                        ]
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getControls(BuildContext context){
    return Center(
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/popups/proceed-btn.png"),
            )
          ],
        ),
      ),
    );
  }
}