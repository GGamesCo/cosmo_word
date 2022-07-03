import 'dart:math';

import 'package:flutter/material.dart';
import '../../GameBL/Services/StoryLocationsService/StoryLocationModel.dart';
import '../../GameBL/Services/StoryLocationsService/StoryLocationsService.dart';
import '../../GameBL/Services/UserStateService/UserStateService.dart';
import '../../GameBL/UserStateController.dart';
import '../../di.dart';

class LobbyMyStory extends StatefulWidget{

  late StoryLocationsService locationsService;
  late UserStateController userStateController;


  LobbyMyStory(){
    locationsService = getIt.get<StoryLocationsService>();
    userStateController = getIt.get<UserStateController>();
  }

  @override
  State<LobbyMyStory> createState() => _LobbyMyStoryState();
}

class _LobbyMyStoryState extends State<LobbyMyStory> {
  late Map<int, LocationStatus> locationStatusData = Map<int, LocationStatus>();

  @override
  void initState(){
    super.initState();

    widget.userStateController.getStoryState().then((state){
      var statuses = Map<int, LocationStatus>();
      for(var loc in widget.locationsService.allLocations){
        var locStatus = LocationStatus.opened;
        if(loc.levels.reduce(max) < state.currentLevelId){
          locStatus = LocationStatus.completed;
        }
        if(loc.levels.reduce(min) > state.currentLevelId){
          locStatus = LocationStatus.locked;
        }
        statuses[loc.id] = locStatus;
      }

      setState((){
        locationStatusData = statuses;
      });
    });
  }

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
            if(locationStatusData.length > 0) ...[
              for(var loc in widget.locationsService.allLocations.take(4)) ...[
                StoryItemCard(
                  imageFile: loc.backgroundFileName,
                  title: loc.title,
                  locationStatus: locationStatusData[loc.id]!,
                  borderRadius: 12,
                ),
              ]
            ]
          ],
        ),
      ),
    );
  }
}

class StoryItemCard extends StatelessWidget {

  final String imageFile;
  final String title;
  final LocationStatus locationStatus;
  final double borderRadius;

  StoryItemCard({
    required this.imageFile,
    required this.title,
    required this.locationStatus,
    required this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Container(/*
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),*/
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                          child: Image.asset("assets/images/backgrounds/${imageFile.replaceAll(".jpg", "_tile.jpg")}")
                        ),
                      ),
                      if(locationStatus == LocationStatus.completed) ...[
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                                width: 25,
                                child: Image.asset('assets/images/widget/completedLocationMark.png')
                            )
                        )
                      ],
                      if(locationStatus == LocationStatus.locked) ...[
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                                width: 25,
                                child: Image.asset('assets/images/widget/lockedLocationMark.png')
                            )
                        )
                      ],
                    ]
                  ),
                ),
                if(title != "") ...[
                  SizedBox(height: 5),
                  Container(
                    child: Text(title, style: TextStyle(color: Color.fromRGBO(116, 126, 126, 1), fontFamily: 'Roboto'), textAlign: TextAlign.center)
                  )
                ]
              ],
            ),
          ),
        )
      )
    );
  }
}