import 'package:cosmo_word/Screens/Common/Story/MyStoryProgress.dart';
import 'package:flutter/material.dart';

class GameCompletePopup extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          child: Center(
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Image.asset("assets/images/popups/popup-bg.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 150),
                        _getCoinReward(),
                        //_getStoryData(),
                        _getTimeChallengeData(),
                        _getControls()
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ),
      ),
    );
  }

  Widget _getCoinReward(){
    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset("assets/images/popups/reward-bg.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  child: Image.asset("assets/images/popups/reward-coin.png")
                )
              ),
              Center(
                child: Text(
                  "+1500",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(131, 135, 125, 1),
                    fontSize: 60
                  ),
                )
              ),
              SizedBox(height: 20)
            ],
          )
        ],
      ),
    );
  }

  Widget _getStoryData(){
    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset("assets/images/popups/story-bg.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: MyStoryProgress(
                  requiredWidth: 260,
                  requiredHeight: 90,
                  progressCurrent: 5,
                  progressTotal: 10,
                ),
              )
            ]
          )
        ],
      ),
    );
  }

  Widget _getTimeChallengeData(){

    var textStyle = TextStyle(
      fontFamily: 'Agency',
      fontSize: 35,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(131, 135, 125, 1)
    );

    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset("assets/images/popups/time-challenge-bg.png"),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
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
          )
        ],
      ),
    );
  }

  Widget _getControls(){
    return Center(
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => {},
              child: Image.asset("assets/images/popups/proceed-btn.png"),
            )
          ],
        ),
      ),
    );
  }
}