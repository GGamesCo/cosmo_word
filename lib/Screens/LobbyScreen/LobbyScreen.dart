import 'dart:async';

import 'package:flutter/material.dart';
import '../Common/Background/StaticBackground.dart';
import '../Common/TopBar/TopBarLayer.dart';
import '../GameScreen/Layers/Popups/GameCompletePopup.dart';
import 'LobbyLogo.dart';
import 'LobbyMyStory.dart';
import 'LobbyNavigation.dart';
import 'package:sizer/sizer.dart';

class LobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), (){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return GameCompletePopup();
          }
      );
    });
    return Scaffold(
      body: Stack(
        children: [
          StaticBackground(fileName: 'green.jpg'),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Container(
              //color: Colors.blue,
              alignment: Alignment.center,
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 8 / 16,
                child: Container(
                  //color: Colors.green,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LobbyLogo(),
                        LobbyNavigation(),
                        LobbyMyStory()
                      ]
                  ),
                ),
              ),
            ),
          ),
          TopBarLayer(
            showBack: false,
            showSettings: true,
            showBalance: true,
          ),
        ],
      ),
    );
  }
}