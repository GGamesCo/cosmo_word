import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@singleton
class SegmentationController{
  String segmentationConfigUrl = "https://raw.githubusercontent.com/GGamesCo/configs/main/segmentationConfig.json";

  Completer initializeCompleter = Completer();
  Map<String, bool> segments = new Map<String, bool>();

  Future initAsync() async {
    while(!initializeCompleter.isCompleted){
      try{
        var response = await http.get(Uri.parse(segmentationConfigUrl));
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
  mixpanelTracker
}
