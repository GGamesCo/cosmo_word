// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import 'Analytics/AnalyticsController.dart' as _i21;
import 'Analytics/AnalyticsServiceApi.dart' as _i3;
import 'Analytics/MixpanelTracker.dart' as _i12;
import 'Analytics/SegmentationController.dart' as _i14;
import 'Flame/Common/SoundsController.dart' as _i16;
import 'GameBL/Common/Abstract/IBalanceController.dart' as _i4;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i6;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i8;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i22;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i10;
import 'GameBL/Common/BalanceController.dart' as _i5;
import 'GameBL/Common/FlowRepository.dart' as _i7;
import 'GameBL/Common/StageManager.dart' as _i25;
import 'GameBL/Common/TimerController.dart' as _i9;
import 'GameBL/Common/UserController.dart' as _i19;
import 'GameBL/Common/WordInputController.dart' as _i23;
import 'GameBL/Common/WordRepository.dart' as _i11;
import 'GameBL/DI/Module.dart' as _i28;
import 'GameBL/Lobby/LobbyStage.dart' as _i24;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i17;
import 'GameBL/Services/StoryLocationsService/StoryLocationsService.dart'
    as _i18;
import 'GameBL/Services/UserStateService/UserStateService.dart' as _i20;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i13;
import 'GameBL/TimeChallenge/TimeAtackStage.dart' as _i27;
import 'GameBL/UserStateController.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AnalyticsServiceApi>(_i3.AnalyticsServiceApi());
  gh.singleton<_i4.IBalanceController>(_i5.BalanceController());
  gh.factory<_i6.IFlowRepository>(() => _i7.FlowRepository());
  gh.factory<_i8.ITimerController>(() => _i9.TimerController());
  gh.factory<_i10.IWordRepository>(() => _i11.WordRepository());
  gh.singleton<_i12.MixpanelTracker>(_i12.MixpanelTracker());
  gh.factory<_i13.RocketChallengeConfig>(() => _i13.RocketChallengeConfig());
  gh.singleton<_i14.SegmentationController>(_i14.SegmentationController());
  gh.factoryAsync<_i15.SharedPreferences>(() => registerModule.prefs);
  gh.singleton<_i16.SoundsController>(_i16.SoundsController());
  gh.singleton<_i17.StoryLevelsService>(_i17.StoryLevelsService());
  gh.singleton<_i18.StoryLocationsService>(_i18.StoryLocationsService());
  gh.singleton<_i19.UserController>(_i19.UserController());
  gh.singletonAsync<_i20.UserStateService>(() async => _i20.UserStateService(
      sharedPreferences: await get.getAsync<_i15.SharedPreferences>()));
  gh.singleton<_i21.AnalyticsController>(_i21.AnalyticsController(
      userController: get<_i19.UserController>(),
      analyticsServiceApi: get<_i3.AnalyticsServiceApi>(),
      mixpanelTracker: get<_i12.MixpanelTracker>(),
      segmentationController: get<_i14.SegmentationController>()));
  gh.factory<_i22.IWordInputController>(() => _i23.WordInputController(
      wordRepository: get<_i10.IWordRepository>(),
      balanceController: get<_i4.IBalanceController>(),
      analyticsController: get<_i21.AnalyticsController>()));
  gh.factory<_i24.LobbyStage>(
      () => _i24.LobbyStage(soundsController: get<_i16.SoundsController>()));
  gh.singleton<_i25.StageManager>(
      _i25.StageManager(analyticsController: get<_i21.AnalyticsController>()));
  gh.singletonAsync<_i26.UserStateController>(() async =>
      _i26.UserStateController(
          userStateService: await get.getAsync<_i20.UserStateService>(),
          levelsService: get<_i17.StoryLevelsService>(),
          flowRepository: get<_i6.IFlowRepository>(),
          balanceController: get<_i4.IBalanceController>(),
          analyticsController: get<_i21.AnalyticsController>()));
  gh.factoryAsync<_i27.TimeAtackStage>(() async => _i27.TimeAtackStage(
      userStateController: await get.getAsync<_i26.UserStateController>(),
      wordRepository: get<_i10.IWordRepository>(),
      wordInputController: get<_i22.IWordInputController>(),
      timerController: get<_i8.ITimerController>(),
      challengeConfig: get<_i13.RocketChallengeConfig>(),
      balanceController: get<_i4.IBalanceController>(),
      soundsController: get<_i16.SoundsController>()));
  return get;
}

class _$RegisterModule extends _i28.RegisterModule {}
