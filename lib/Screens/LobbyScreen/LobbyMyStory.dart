import 'package:flutter/material.dart';

import '../Common/Story/MyStoryProgress.dart';

class LobbyMyStory extends StatelessWidget{

  LobbyMyStory();

  @override
  Widget build(BuildContext context){

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/lobby/lobby-my-story.png'), fit: BoxFit.fitWidth)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StoryItemCard(imageFile: 'assets/images/backgrounds/green_tile.jpg', title: "Welcome party"),
            StoryItemCard(imageFile: 'assets/images/backgrounds/beach_with_boat_tile.jpg', title: "Mystery iceland"),
            StoryItemCard(imageFile: 'assets/images/backgrounds/jungles_tile.jpg', title: "Wild jungle"),
            StoryItemCard(imageFile: 'assets/images/backgrounds/blue_tile.jpg', title: "Windy voyage")
          ],
        ),
      ),
    );
  }
}

class StoryItemCard extends StatelessWidget {

  final String imageFile;
  final String title;

  StoryItemCard({required this.imageFile, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Image.asset(imageFile)
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(title, style: TextStyle(color: Color.fromRGBO(116, 126, 126, 1), fontFamily: 'Roboto'), textAlign: TextAlign.center)
                      )
                    ],
                  ),
                ),
              )
            ),/*
            Center(
              child: SizedBox(
                width: 25,
                child: Image.asset('assets/images/widget/lock.png')
              )
            )*/
          ]
        ),
      )
    );
  }
}