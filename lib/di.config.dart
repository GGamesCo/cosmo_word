// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import 'Analytics/AnalyticsController.dart' as _i19;
import 'Flame/Common/SoundsController.dart' as _i13;
import 'GameBL/Common/Abstract/IBalanceController.dart' as _i3;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i5;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i7;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i20;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i9;
import 'GameBL/Common/BalanceController.dart' as _i4;
import 'GameBL/Common/FlowRepository.dart' as _i6;
import 'GameBL/Common/StageManager.dart' as _i14;
import 'GameBL/Common/TimerController.dart' as _i8;
import 'GameBL/Common/UserController.dart' as _i18;
import 'GameBL/Common/WordInputController.dart' as _i21;
import 'GameBL/Common/WordRepository.dart' as _i10;
import 'GameBL/DI/Module.dart' as _i25;
import 'GameBL/Lobby/LobbyStage.dart' as _i22;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i15;
import 'GameBL/Services/StoryLocationsService/StoryLocationsService.dart'
    as _i16;
import 'GameBL/Services/StoryStateService/StoryStateService.dart' as _i17;
import 'GameBL/Story/StoryStateController.dart' as _i23;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i11;
import 'GameBL/TimeChallenge/TimeAtackStage.dart'
    as _i24; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.IBalanceController>(_i4.BalanceController());
  gh.factory<_i5.IFlowRepository>(() => _i6.FlowRepository());
  gh.factory<_i7.ITimerController>(() => _i8.TimerController());
  gh.factory<_i9.IWordRepository>(() => _i10.WordRepository());
  gh.factory<_i11.RocketChallengeConfig>(() => _i11.RocketChallengeConfig());
  gh.factoryAsync<_i12.SharedPreferences>(() => registerModule.prefs);
  gh.singleton<_i13.SoundsController>(_i13.SoundsController());
  gh.singleton<_i14.StageManager>(_i14.StageManager());
  gh.singleton<_i15.StoryLevelsService>(_i15.StoryLevelsService());
  gh.singleton<_i16.StoryLocationsService>(_i16.StoryLocationsService());
  gh.singleton<_i17.StoryStateService>(_i17.StoryStateService());
  gh.singleton<_i18.UserController>(_i18.UserController());
  gh.singleton<_i19.AnalyticsController>(
      _i19.AnalyticsController(userController: get<_i18.UserController>()));
  gh.factory<_i20.IWordInputController>(() => _i21.WordInputController(
      wordRepository: get<_i9.IWordRepository>(),
      balanceController: get<_i3.IBalanceController>()));
  gh.factory<_i22.LobbyStage>(
      () => _i22.LobbyStage(soundsController: get<_i13.SoundsController>()));
  gh.singleton<_i23.StoryStateController>(_i23.StoryStateController(
      storyStateService: get<_i17.StoryStateService>(),
      levelsService: get<_i15.StoryLevelsService>(),
      flowRepository: get<_i5.IFlowRepository>(),
      balanceController: get<_i3.IBalanceController>()));
  gh.factory<_i24.TimeAtackStage>(() => _i24.TimeAtackStage(
      wordRepository: get<_i9.IWordRepository>(),
      wordInputController: get<_i20.IWordInputController>(),
      timerController: get<_i7.ITimerController>(),
      challengeConfig: get<_i11.RocketChallengeConfig>(),
      balanceController: get<_i3.IBalanceController>(),
      soundsController: get<_i13.SoundsController>()));
  return get;
}

class _$RegisterModule extends _i25.RegisterModule {}
