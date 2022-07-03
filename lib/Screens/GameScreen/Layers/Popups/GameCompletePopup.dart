import 'dart:math';

import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Screens/Common/Story/MyStoryProgress.dart';
import 'package:cosmo_word/TabletDetector.dart';
import 'package:flutter/material.dart';
import '../../../../GameBL/Common/Models/GameState.dart';
import '../../../../GameBL/Common/StageManager.dart';
import '../../../../GameBL/Services/UserStateService/UserStateModel.dart';
import '../../../../GameBL/TimeChallenge/TimeChallengeResults.dart';
import '../../../../di.dart';

class GameCompletePopup extends StatelessWidget{

  final popupType;
  final UserStateModel storyStateModel;
  final int completedLevelId;
  final int coinReward;
  final TimeChallengeResults? timeChallengeResults;

  GameCompletePopup({
    required this.popupType,
    required this.storyStateModel,
    required this.completedLevelId,
    required this.coinReward,
    this.timeChallengeResults
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 7.5 / 16,
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
                                    _getTimeChallengeData(timeChallengeResults!),
                                  ],
                                  SizedBox(height: 15),
                                  Expanded(child: _getControls(context))
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
    var storyHeaderHeight = !TabletDetector.isTablet() ? 50 : 80;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: !TabletDetector.isTablet() ? 10 : 30),
          child: Column(
            children: [
              SizedBox(height: storyHeaderHeight/2),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.19),
                        spreadRadius: 6,
                        blurRadius: 14,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: MyStoryProgress(completedLevelId: completedLevelId),
                  )
              ),
            ],
          ),
        ),
        SizedBox(
          height: storyHeaderHeight*1,
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/popups/story-bg-header.png")
          ),
        ),
      ]
    );
  }

  Widget _getTimeChallengeData(TimeChallengeResults results){

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
                            Text("${results.reachedHeight}m", style: textStyle.copyWith(color: Color.fromRGBO(107, 160, 22, 1))),
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
                              Text("${max(results.lastRecord, results.reachedHeight)}m", style: textStyle.copyWith(color: Color.fromRGBO(107, 160, 22, 1))),
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
                if(popupType == 1) {
                  getIt.get<StageManager>().navigateToStage(GameStage.Story, context);
                }
                if(popupType == 2) {
                  getIt.get<StageManager>().navigateToStage(GameStage.TimeAtack, context);
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