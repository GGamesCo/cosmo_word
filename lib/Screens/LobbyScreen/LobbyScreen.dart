import 'dart:async';
import 'dart:math';

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
    /*
    Timer(Duration(seconds: 1), (){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return GameCompletePopup();
          }
      );
    });
   */

    var lobbyWidth = min(MediaQuery.of(context).size.width, 650);

    return Scaffold(
      body: Stack(
        children: [
          StaticBackground(fileName: 'green.jpg'),
          Center(
            child: Container(
              //color: Colors.blue,
              alignment: Alignment.center,
              width: lobbyWidth*1,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 60),
                      LobbyLogo(),
                      LobbyNavigation(),
                      LobbyMyStory()
                    ]
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