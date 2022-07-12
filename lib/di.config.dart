// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;

import 'Analytics/AnalyticsController.dart' as _i20;
import 'Analytics/AnalyticsServiceApi.dart' as _i3;
import 'Analytics/MixpanelTracker.dart' as _i12;
import 'Flame/Common/SoundsController.dart' as _i15;
import 'GameBL/Common/Abstract/IBalanceController.dart' as _i4;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i6;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i8;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i21;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i10;
import 'GameBL/Common/BalanceController.dart' as _i5;
import 'GameBL/Common/FlowRepository.dart' as _i7;
import 'GameBL/Common/StageManager.dart' as _i24;
import 'GameBL/Common/TimerController.dart' as _i9;
import 'GameBL/Common/UserController.dart' as _i18;
import 'GameBL/Common/WordInputController.dart' as _i22;
import 'GameBL/Common/WordRepository.dart' as _i11;
import 'GameBL/DI/Module.dart' as _i27;
import 'GameBL/Lobby/LobbyStage.dart' as _i23;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i16;
import 'GameBL/Services/StoryLocationsService/StoryLocationsService.dart'
    as _i17;
import 'GameBL/Services/UserStateService/UserStateService.dart' as _i19;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i13;
import 'GameBL/TimeChallenge/TimeAtackStage.dart' as _i26;
import 'GameBL/UserStateController.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

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
  gh.factoryAsync<_i14.SharedPreferences>(() => registerModule.prefs);
  gh.singleton<_i15.SoundsController>(_i15.SoundsController());
  gh.singleton<_i16.StoryLevelsService>(_i16.StoryLevelsService());
  gh.singleton<_i17.StoryLocationsService>(_i17.StoryLocationsService());
  gh.singleton<_i18.UserController>(_i18.UserController());
  gh.singletonAsync<_i19.UserStateService>(() async => _i19.UserStateService(
      sharedPreferences: await get.getAsync<_i14.SharedPreferences>()));
  gh.singleton<_i20.AnalyticsController>(_i20.AnalyticsController(
      userController: get<_i18.UserController>(),
      analyticsServiceApi: get<_i3.AnalyticsServiceApi>(),
      mixpanelTracker: get<_i12.MixpanelTracker>()));
  gh.factory<_i21.IWordInputController>(() => _i22.WordInputController(
      wordRepository: get<_i10.IWordRepository>(),
      balanceController: get<_i4.IBalanceController>(),
      analyticsController: get<_i20.AnalyticsController>()));
  gh.factory<_i23.LobbyStage>(
      () => _i23.LobbyStage(soundsController: get<_i15.SoundsController>()));
  gh.singleton<_i24.StageManager>(
      _i24.StageManager(analyticsController: get<_i20.AnalyticsController>()));
  gh.singletonAsync<_i25.UserStateController>(() async =>
      _i25.UserStateController(
          userStateService: await get.getAsync<_i19.UserStateService>(),
          levelsService: get<_i16.StoryLevelsService>(),
          flowRepository: get<_i6.IFlowRepository>(),
          balanceController: get<_i4.IBalanceController>(),
          analyticsController: get<_i20.AnalyticsController>()));
  gh.factoryAsync<_i26.TimeAtackStage>(() async => _i26.TimeAtackStage(
      userStateController: await get.getAsync<_i25.UserStateController>(),
      wordRepository: get<_i10.IWordRepository>(),
      wordInputController: get<_i21.IWordInputController>(),
      timerController: get<_i8.ITimerController>(),
      challengeConfig: get<_i13.RocketChallengeConfig>(),
      balanceController: get<_i4.IBalanceController>(),
      soundsController: get<_i15.SoundsController>()));
  return get;
}

class _$RegisterModule extends _i27.RegisterModule {}
