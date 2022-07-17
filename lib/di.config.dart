// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import 'Analytics/AnalyticsController.dart' as _i16;
import 'Analytics/AnalyticsServiceApi.dart' as _i3;
import 'Analytics/MixpanelTracker.dart' as _i8;
import 'Analytics/SegmentationController.dart' as _i10;
import 'Flame/Common/SoundsController.dart' as _i12;
import 'GameBL/Common/Abstract/IBalanceController.dart' as _i4;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i18;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i6;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i26;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i20;
import 'GameBL/Common/BalanceController.dart' as _i5;
import 'GameBL/Common/FlowRepository.dart' as _i19;
import 'GameBL/Common/StageManager.dart' as _i23;
import 'GameBL/Common/TimerController.dart' as _i7;
import 'GameBL/Common/UserController.dart' as _i14;
import 'GameBL/Common/WordInputController.dart' as _i27;
import 'GameBL/Common/WordRepository.dart' as _i21;
import 'GameBL/Configs/GameConfigController.dart' as _i17;
import 'GameBL/DI/Module.dart' as _i29;
import 'GameBL/Lobby/LobbyStage.dart' as _i22;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i24;
import 'GameBL/Services/StoryLocationsService/StoryLocationsService.dart'
    as _i13;
import 'GameBL/Services/UserStateService/UserStateService.dart' as _i15;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i9;
import 'GameBL/TimeChallenge/TimeAtackStage.dart' as _i28;
import 'GameBL/UserStateController.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AnalyticsServiceApi>(_i3.AnalyticsServiceApi());
  gh.singleton<_i4.IBalanceController>(_i5.BalanceController());
  gh.factory<_i6.ITimerController>(() => _i7.TimerController());
  gh.singleton<_i8.MixpanelTracker>(_i8.MixpanelTracker());
  gh.factory<_i9.RocketChallengeConfig>(() => _i9.RocketChallengeConfig());
  gh.singleton<_i10.SegmentationController>(_i10.SegmentationController());
  await gh.factoryAsync<_i11.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.singleton<_i12.SoundsController>(_i12.SoundsController());
  gh.singleton<_i13.StoryLocationsService>(_i13.StoryLocationsService());
  gh.singleton<_i14.UserController>(_i14.UserController());
  gh.singleton<_i15.UserStateService>(
      _i15.UserStateService(sharedPreferences: get<_i11.SharedPreferences>()));
  gh.singleton<_i16.AnalyticsController>(_i16.AnalyticsController(
      userController: get<_i14.UserController>(),
      analyticsServiceApi: get<_i3.AnalyticsServiceApi>(),
      mixpanelTracker: get<_i8.MixpanelTracker>(),
      segmentationController: get<_i10.SegmentationController>()));
  gh.singleton<_i17.GameConfigController>(_i17.GameConfigController(
      get<_i16.AnalyticsController>(), get<_i10.SegmentationController>()));
  gh.factory<_i18.IFlowRepository>(
      () => _i19.FlowRepository(get<_i17.GameConfigController>()));
  gh.factory<_i20.IWordRepository>(
      () => _i21.WordRepository(get<_i17.GameConfigController>()));
  gh.factory<_i22.LobbyStage>(
      () => _i22.LobbyStage(soundsController: get<_i12.SoundsController>()));
  gh.singleton<_i23.StageManager>(
      _i23.StageManager(analyticsController: get<_i16.AnalyticsController>()));
  gh.singleton<_i24.StoryLevelsService>(
      _i24.StoryLevelsService(get<_i17.GameConfigController>()));
  gh.singleton<_i25.UserStateController>(_i25.UserStateController(
      userStateService: get<_i15.UserStateService>(),
      levelsService: get<_i24.StoryLevelsService>(),
      flowRepository: get<_i18.IFlowRepository>(),
      balanceController: get<_i4.IBalanceController>(),
      analyticsController: get<_i16.AnalyticsController>()));
  gh.factory<_i26.IWordInputController>(() => _i27.WordInputController(
      wordRepository: get<_i20.IWordRepository>(),
      balanceController: get<_i4.IBalanceController>(),
      analyticsController: get<_i16.AnalyticsController>()));
  gh.factory<_i28.TimeAtackStage>(() => _i28.TimeAtackStage(
      userStateController: get<_i25.UserStateController>(),
      wordRepository: get<_i20.IWordRepository>(),
      wordInputController: get<_i26.IWordInputController>(),
      timerController: get<_i6.ITimerController>(),
      challengeConfig: get<_i9.RocketChallengeConfig>(),
      balanceController: get<_i4.IBalanceController>(),
      soundsController: get<_i12.SoundsController>()));
  return get;
}

class _$RegisterModule extends _i29.RegisterModule {}
