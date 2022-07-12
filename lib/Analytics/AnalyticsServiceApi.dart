import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class AnalyticsServiceApi
{
  Completer initializationCompleter = Completer();

  String configUrl = "https://raw.githubusercontent.com/GGamesCo/configs/main/hosts.json";
  AnalyticsConfig? config;

  Future initAsync() async {
    while (!initializationCompleter.isCompleted){
      try{
        print("Getting analytics config.");
        var configResponse = await http.get(Uri.parse(configUrl));
        Map<String, dynamic> response = jsonDecode(configResponse.body);
        print("Analytics config response: " + response.toString());

        config = AnalyticsConfig.fromJson(response);

        initializationCompleter.complete();
      }catch(e){
        print("AnalyticsServiceApi.initAsync error = " + e.toString());
        await Future.delayed(Duration(seconds: 10));
      }
    }
  }

  Future sendEvent(String eventName, Map<String, Object> params) async {
    if (!initializationCompleter.isCompleted){
      print("Waiting for initialization to complete.");
      await initializationCompleter;
    }

    params["event_name"] = eventName;

    try{
      var uri = Uri.parse(config!.host + config!.post_event_path);
      await makePostRequestAsync(uri, params);
    }
    catch(e){
      try{
        var uri = Uri.parse(config!.host + config!.post_event_path);
        await makePostRequestAsync(uri, params);
      } catch(e){}
    }
  }

  Future makePostRequestAsync(Uri uri, Map<String, Object> params) async{
    try{
      await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params),
      );
    }catch(e){
      print("Error while sending event. ${e}");
    }
  }
}

class AnalyticsConfig{
  String host;
  String post_event_path;

  AnalyticsConfig(this.host, this.post_event_path);

  AnalyticsConfig.fromJson(Map<String, dynamic> json)
      : host = json["analytics"]['host'],
        post_event_path = json["analytics"]['post_event_path'];
}