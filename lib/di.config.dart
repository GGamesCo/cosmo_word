// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import 'Analytics/AnalyticsController.dart' as _i19;
import 'Analytics/AnalyticsServiceApi.dart' as _i3;
import 'Flame/Common/SoundsController.dart' as _i14;
import 'GameBL/Common/Abstract/IBalanceController.dart' as _i4;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i6;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i8;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i20;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i10;
import 'GameBL/Common/BalanceController.dart' as _i5;
import 'GameBL/Common/FlowRepository.dart' as _i7;
import 'GameBL/Common/StageManager.dart' as _i23;
import 'GameBL/Common/TimerController.dart' as _i9;
import 'GameBL/Common/UserController.dart' as _i17;
import 'GameBL/Common/WordInputController.dart' as _i21;
import 'GameBL/Common/WordRepository.dart' as _i11;
import 'GameBL/DI/Module.dart' as _i26;
import 'GameBL/Lobby/LobbyStage.dart' as _i22;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i15;
import 'GameBL/Services/StoryLocationsService/StoryLocationsService.dart'
    as _i16;
import 'GameBL/Services/UserStateService/UserStateService.dart' as _i18;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i12;
import 'GameBL/TimeChallenge/TimeAtackStage.dart' as _i25;
import 'GameBL/UserStateController.dart'
    as _i24; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i12.RocketChallengeConfig>(() => _i12.RocketChallengeConfig());
  gh.factoryAsync<_i13.SharedPreferences>(() => registerModule.prefs);
  gh.singleton<_i14.SoundsController>(_i14.SoundsController());
  gh.singleton<_i15.StoryLevelsService>(_i15.StoryLevelsService());
  gh.singleton<_i16.StoryLocationsService>(_i16.StoryLocationsService());
  gh.singleton<_i17.UserController>(_i17.UserController());
  gh.singletonAsync<_i18.UserStateService>(() async => _i18.UserStateService(
      sharedPreferences: await get.getAsync<_i13.SharedPreferences>()));
  gh.singleton<_i19.AnalyticsController>(_i19.AnalyticsController(
      userController: get<_i17.UserController>(),
      analyticsServiceApi: get<_i3.AnalyticsServiceApi>()));
  gh.factory<_i20.IWordInputController>(() => _i21.WordInputController(
      wordRepository: get<_i10.IWordRepository>(),
      balanceController: get<_i4.IBalanceController>(),
      analyticsController: get<_i19.AnalyticsController>()));
  gh.factory<_i22.LobbyStage>(
      () => _i22.LobbyStage(soundsController: get<_i14.SoundsController>()));
  gh.singleton<_i23.StageManager>(
      _i23.StageManager(analyticsController: get<_i19.AnalyticsController>()));
  gh.singletonAsync<_i24.UserStateController>(() async =>
      _i24.UserStateController(
          userStateService: await get.getAsync<_i18.UserStateService>(),
          levelsService: get<_i15.StoryLevelsService>(),
          flowRepository: get<_i6.IFlowRepository>(),
          balanceController: get<_i4.IBalanceController>(),
          analyticsController: get<_i19.AnalyticsController>()));
  gh.factoryAsync<_i25.TimeAtackStage>(() async => _i25.TimeAtackStage(
      userStateController: await get.getAsync<_i24.UserStateController>(),
      wordRepository: get<_i10.IWordRepository>(),
      wordInputController: get<_i20.IWordInputController>(),
      timerController: get<_i8.ITimerController>(),
      challengeConfig: get<_i12.RocketChallengeConfig>(),
      balanceController: get<_i4.IBalanceController>(),
      soundsController: get<_i14.SoundsController>()));
  return get;
}

class _$RegisterModule extends _i26.RegisterModule {}
