import 'package:flutter/material.dart';

import '../Common/Story/MyStoryProgress.dart';

class LobbyMyStory extends StatelessWidget{

  LobbyMyStory();

  @override
  Widget build(BuildContext context){
    return IntrinsicHeight(
      child: Stack(
        children: [
          Container(
            child: Image.asset('assets/images/lobby/lobby-my-story.png'),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: MyStoryProgress(
                requiredWidth: 260,
                requiredHeight: 90,
                progressCurrent: 2,
                progressTotal: 3
              ),
            )
          )
        ]
      ),
    );
  }
}