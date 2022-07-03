import 'package:cosmo_word/GameBL/Services/StoryLocationsService/StoryLocationModel.dart';
import 'package:cosmo_word/GameBL/Services/StoryLocationsService/StoryLocationsService.dart';
import 'package:cosmo_word/Screens/LobbyScreen/LobbyMyStory.dart';
import 'package:cosmo_word/TabletDetector.dart';
import 'package:flutter/material.dart';

import '../../../GameBL/UserStateController.dart';
import '../../../di.dart';

class MyStoryProgress extends StatefulWidget {

  final int completedLevelId;

  late UserStateController userStateController;
  late StoryLocationsService storyLocationsService;

  MyStoryProgress({required this.completedLevelId}){
    userStateController = getIt.get<UserStateController>();
    storyLocationsService = getIt.get<StoryLocationsService>();
  }

  @override
  State<MyStoryProgress> createState() => _MyStoryProgressState();
}

class _MyStoryProgressState extends State<MyStoryProgress> {

  late dynamic progressBarState = null;
  late dynamic nextLocationState = null;

  @override
  void initState(){
    super.initState();

    widget.userStateController.getStoryState().then((state) async {
      var completedLevelId = widget.completedLevelId;
      var completedLevelLocation = await widget.storyLocationsService.getLocationConfigByLevelId(completedLevelId);
      var completedLevelIndexInLocation = completedLevelLocation.levels.indexOf(completedLevelId);
      var barState = {'currentProgress': completedLevelIndexInLocation+1, 'targetProgress': completedLevelLocation.levels.length};
      var indexOfCurrent = widget.storyLocationsService.allLocations.indexOf(completedLevelLocation);
      var locationStatus = completedLevelId == completedLevelLocation.levels.last ? LocationStatus.opened : LocationStatus.locked;
      var nextLocation = widget.storyLocationsService.allLocations[indexOfCurrent+1];
      var nextLocState = {'imageFile': nextLocation.backgroundFileName, 'locationStatus': locationStatus};
      setState((){
        progressBarState = barState;
        nextLocationState = nextLocState;
      });
    });
  }

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
                      value: progressBarState!= null ? progressBarState['currentProgress']/progressBarState['targetProgress'] : 0,
                      minHeight: 30,
                      backgroundColor: Color.fromRGBO(131, 135, 125, 1),
                      color: Color.fromRGBO(255, 207, 123, 1),
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                  SizedBox(height: 5),
                  if(nextLocationState != null && nextLocationState['locationStatus'] == LocationStatus.opened) ...[
                    Text(
                      "New location available!",
                      style: TextStyle(
                        color: Color.fromRGBO(131, 135, 125, 1),
                        fontSize: !TabletDetector.isTablet() ? 18 : 28,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                  if(nextLocationState != null && nextLocationState['locationStatus'] == LocationStatus.locked) ...[
                    Text(
                      progressBarState!= null ? "Progress: ${progressBarState['currentProgress']}/${progressBarState['targetProgress']}" : "",
                      style: TextStyle(
                        color: Color.fromRGBO(131, 135, 125, 1),
                        fontSize: !TabletDetector.isTablet() ? 18 : 28,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          if(nextLocationState != null) ...[
            Flexible(
              flex: 2,
              child: StoryItemCard(
                imageFile: nextLocationState['imageFile'],
                locationStatus: nextLocationState['locationStatus'],
                title: "",
                borderRadius: 8,
              ),
            ),
          ]
        ],
      ),
    );
  }
}