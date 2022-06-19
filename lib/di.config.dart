// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import 'GameBL/Common/Abstract/IBalanceController.dart' as _i3;
import 'GameBL/Common/Abstract/IFlowRepository.dart' as _i5;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i7;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i16;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i9;
import 'GameBL/Common/BalanceController.dart' as _i4;
import 'GameBL/Common/FlowRepository.dart' as _i6;
import 'GameBL/Common/StageManager.dart' as _i13;
import 'GameBL/Common/TimerController.dart' as _i8;
import 'GameBL/Common/WordInputController.dart' as _i17;
import 'GameBL/Common/WordRepository.dart' as _i10;
import 'GameBL/DI/Module.dart' as _i20;
import 'GameBL/Services/StoryLevelsService/StoryLevelsService.dart' as _i14;
import 'GameBL/Services/StoryStateService/StoryStateService.dart' as _i15;
import 'GameBL/Story/StoryStateController.dart' as _i18;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i11;
import 'GameBL/TimeChallenge/TimeAtackStage.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i13.StageManager>(_i13.StageManager());
  gh.singleton<_i14.StoryLevelsService>(_i14.StoryLevelsService());
  gh.singleton<_i15.StoryStateService>(_i15.StoryStateService());
  gh.factory<_i16.IWordInputController>(() => _i17.WordInputController(
      flowRepository: get<_i5.IFlowRepository>(),
      wordRepository: get<_i9.IWordRepository>()));
  gh.singleton<_i18.StoryStateController>(_i18.StoryStateController(
      storyStateService: get<_i15.StoryStateService>(),
      levelsService: get<_i14.StoryLevelsService>(),
      flowRepository: get<_i5.IFlowRepository>(),
      wordInputController: get<_i16.IWordInputController>()));
  gh.factory<_i19.TimeAtackStage>(() => _i19.TimeAtackStage(
      wordInputController: get<_i16.IWordInputController>(),
      timerController: get<_i7.ITimerController>(),
      challengeConfig: get<_i11.RocketChallengeConfig>(),
      balanceController: get<_i3.IBalanceController>()));
  return get;
}

class _$RegisterModule extends _i20.RegisterModule {}
