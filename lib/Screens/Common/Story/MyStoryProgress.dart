import 'package:cosmo_word/GameBL/Services/StoryLocationsService/StoryLocationModel.dart';
import 'package:cosmo_word/Screens/LobbyScreen/LobbyMyStory.dart';
import 'package:cosmo_word/TabletDetector.dart';
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
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: progressCurrent/progressTotal,
                      minHeight: 30,
                      backgroundColor: Color.fromRGBO(131, 135, 125, 1),
                      color: Color.fromRGBO(255, 207, 123, 1),
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Progress: ${progressCurrent}/${progressTotal}",
                    style: TextStyle(
                      color: Color.fromRGBO(131, 135, 125, 1),
                      fontSize: !TabletDetector.isTablet() ? 18 : 28,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: StoryItemCard(
              imageFile: 'assets/images/backgrounds/blue_tile.jpg',
              locationStatus: LocationStatus.locked,
              title: "",
              borderRadius: 8,
            ),
          ),
        ],
      ),
    );
  }
}