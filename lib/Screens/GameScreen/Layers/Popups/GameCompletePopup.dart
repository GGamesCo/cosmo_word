import 'package:cosmo_word/Screens/Common/Story/MyStoryProgress.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Flame/StoryGame.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateModel.dart';
import '../../../../GameBL/Services/StoryStateService/StoryStateService.dart';
import '../../../../GameBL/Story/StoryStateController.dart';
import '../../../../di.dart';
import '../../../../main.dart';
import '../../GameScreen.dart';

class GameCompletePopup extends StatelessWidget{

  final popupType;
  final StoryStateModel storyStateModel;
  final double coinReward;

  GameCompletePopup({
    required this.popupType,
    required this.storyStateModel,
    required this.coinReward
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 7 / 16,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset("assets/images/popups/popup-bg.png")),
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
                              child: Column(
                                children: [
                                  _getCoinReward(),
                                  if(popupType == 1) ...[
                                    _getStoryData(),
                                  ],
                                  if(popupType == 2) ...[
                                    _getTimeChallengeData(),
                                  ],
                                  Expanded(child: _getControls())
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

  Widget _getCoinReward(){
    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.asset("assets/images/popups/reward-bg.png"),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(height: 100, child: Image.asset("assets/images/popups/reward-coin.png"))
                ),
                Center(
                  child: Text(
                    "+${coinReward.round()}",
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

  Widget _getStoryData(){
    return IntrinsicHeight(
      child: Stack(
          children: [
            Container(
              child: Image.asset("assets/images/popups/story-bg.png"),
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: MyStoryProgress(
                      progressCurrent: storyStateModel.currentLevelNumber,
                      progressTotal: storyStateModel.nextMilestoneTargetLevel
                  ),
                )
            )
          ]
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

  Widget _getControls(){
    return Center(
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if(popupType == 1) {
                  Navigator.push(
                    navigatorKey.currentContext!,
                    MaterialPageRoute(builder: (context) =>
                        GameScreen(
                            gameScreenKey: GlobalKey(),
                            game: StoryGame(storyStateController: getIt.get<StoryStateController>())
                        )
                    ),
                  );
                }
              },
              child: Image.asset("assets/images/popups/proceed-btn.png"),
            )
          ],
        ),
      ),
    );
  }
}