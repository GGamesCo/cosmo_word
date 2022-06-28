import 'dart:math';

import 'package:flutter/material.dart';

import '../../GameBL/Services/StoryLocationsService/StoryLocationModel.dart';
import '../../GameBL/Services/StoryLocationsService/StoryLocationsService.dart';
import '../../GameBL/Services/StoryStateService/StoryStateService.dart';
import '../../di.dart';

class LobbyMyStory extends StatefulWidget{

  late List<StoryLocationModel> locations = [];

  late StoryLocationsService locationsService;
  late StoryStateService storyStateService;
  late Map<int, LocationStatus> locationStatus = Map<int, LocationStatus>();

  LobbyMyStory(){
    locationsService = getIt.get<StoryLocationsService>();
    storyStateService = getIt.get<StoryStateService>();
  }

  @override
  State<LobbyMyStory> createState() => _LobbyMyStoryState();
}

class _LobbyMyStoryState extends State<LobbyMyStory> {

  @override
  void initState(){
    super.initState();

    for(var loc in widget.locationsService.allLocations){
      var locStatus = LocationStatus.opened;
      if(loc.levels.reduce(max) < widget.storyStateService.currentLevelId){
        locStatus = LocationStatus.completed;
      }
      if(loc.levels.reduce(min) > widget.storyStateService.currentLevelId){
        locStatus = LocationStatus.locked;
      }
      widget.locationStatus[loc.id] = locStatus;
    }

    setState(() {
      widget.locations = widget.locationsService.allLocations;
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
            for(var loc in widget.locations.take(4)) ...[
              StoryItemCard(
                imageFile: "assets/images/backgrounds/${loc.backgroundFileName.replaceAll(".jpg", "_tile.jpg")}",
                title: loc.title,
                locationStatus: widget.locationStatus[loc.id]!,
              ),
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

  StoryItemCard({required this.imageFile, required this.title, required this.locationStatus});

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
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.asset(imageFile)
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
                SizedBox(height: 5),
                Container(
                  child: Text(title, style: TextStyle(color: Color.fromRGBO(116, 126, 126, 1), fontFamily: 'Roboto'), textAlign: TextAlign.center)
                )
              ],
            ),
          ),
        )
      )
    );
  }
}