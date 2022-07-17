import 'dart:async';
import 'dart:convert';

import 'package:cosmo_word/Analytics/AnalyticEvent.dart';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@singleton
class SegmentationController{
  String segmentationConfigUrl = "https://raw.githubusercontent.com/GGamesCo/configs/main/segmentationConfig.json";

  final AnalyticsController _analyticsController;

  SegmentationController(this._analyticsController);

  Completer initializeCompleter = Completer();
  Map<String, bool> segments = new Map<String, bool>();

  Future initAsync() async {
    while(!initializeCompleter.isCompleted){
      try{
        var response = await http.get(Uri.parse(segmentationConfigUrl));
        _analyticsController.logEventAsync(AnalyticEvents.SEGMENTATION_LOADED, params: {"segmentation_response": response.body});
        segments = Map<String, bool>.from(jsonDecode(response.body));
      }catch(e){
        print("Error while evaluating segmentation. ${e} \nWait 10 seconds and retry.");
        await Future.delayed(Duration(seconds: 10));
      }

      initializeCompleter.complete();
    }
  }

  bool isEnabled(FeatureType feature){
    var featureName = feature.name.split(".").last;

    if(!initializeCompleter.isCompleted || !segments.containsKey(featureName))
      return false;

    return segments[featureName]!;
  }
}

enum FeatureType{
  analytics,
  mixpanelTracker,
  remoteLevelsConfig,
  reloadLevelsConfigIfSameVersion,

  reloadLevelsConfigIfNewVersionExist, // USE CAREFUL MAY BREAK USER EXPERIENCE
}
