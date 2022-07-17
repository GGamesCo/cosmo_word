import 'dart:async';
import 'dart:convert';
import 'package:cosmo_word/Analytics/AnalyticsController.dart';
import 'package:cosmo_word/Analytics/SegmentationController.dart';
import 'package:cosmo_word/GameBL/Configs/GameConfigModel.dart';
import 'package:cosmo_word/di.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Analytics/AnalyticEvent.dart';

@singleton
class GameConfigController{
  static String localConfigKey = "levelsConfig";
  static String levelsConfigUrl = "https://raw.githubusercontent.com/GGamesCo/configs/main/levelConfigs/config.json";
  static String levelsConfigLocalUrl = "configs/defaultGameConfig.json";

  final AnalyticsController _analytics;
  final SegmentationController _segmentationController;

  late GameConfigModel gameConfigModel;

  GameConfigController(this._analytics, this._segmentationController);

  Future initAsync() async{
    GameConfigModel? localConfig = null;

    var localStorage = getIt.get<SharedPreferences>();
    if (localStorage.containsKey(localConfigKey)){
      try{
        localConfig = _getModelFromJsonString(localStorage.getString(localConfigKey)!);
        _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_LOAD_CACHED, params: {"levels_config_version" : localConfig!.version});
      }
      catch (e){
        _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_LOAD_CACHED_FAILED, params: {"error" : e.toString()});
        print("Load saved config failed ${e.toString()}");
      }
    }

    if (_segmentationController.isEnabled(FeatureType.remoteLevelsConfig)){
      var remoteConfig = await downloadConfigAsync();

      if (remoteConfig != null){
        if (_segmentationController.isEnabled(FeatureType.reloadLevelsConfigIfNewVersionExist)){
          _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_USE_REMOTE, params: {"levels_config_version" : remoteConfig!.version, "local_levels_config_version": localConfig?.version ?? -1});
          localConfig = remoteConfig;
        }

        if (_segmentationController.isEnabled(FeatureType.reloadLevelsConfigIfSameVersion)
            && (localConfig == null || localConfig!.version == remoteConfig.version)){
          _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_USE_REMOTE, params: {"levels_config_version" : remoteConfig!.version, "local_levels_config_version": localConfig?.version ?? -1});
          localConfig = remoteConfig;
        }
      }
    }

    if (localConfig == null){
      final String gameConfigLocalJson = await rootBundle.loadString("configs/defaultGameConfig.json");
      localConfig = _getModelFromJsonString(gameConfigLocalJson);
      _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_USE_INCLUDED, params: {"levels_config_version" : localConfig!.version});
    }

    gameConfigModel = localConfig;
    localStorage.setString(localConfigKey, jsonEncode(gameConfigModel));
  }

  Future<GameConfigModel?> downloadConfigAsync() async{
    var attempts = 3;
    GameConfigModel? config = null;

    while (config == null && attempts > 0){
      try{
        var response = await http.get(Uri.parse(levelsConfigUrl));
        config = _getModelFromJsonString(response.body);
      }catch(e){
        print("Error while evaluating segmentation. ${e} \nWait 3 seconds and retry.");
        await Future.delayed(Duration(seconds: 3));
        _analytics.logEventAsync(AnalyticEvents.LEVELS_CONFIG_DOWNLOAD_FAILED, params: { "attempt" : attempts, "error": e.toString() });
        attempts = attempts - 1;
      }
    }

    return config;
  }

  GameConfigModel _getModelFromJsonString(String str){
    return GameConfigModel.fromJson(jsonDecode(str));
  }
}