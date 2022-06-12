// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import 'GameBL/Common/Abstract/IBalanceController.dart' as _i3;
import 'GameBL/Common/Abstract/ITimerController.dart' as _i5;
import 'GameBL/Common/Abstract/IWordInputController.dart' as _i11;
import 'GameBL/Common/Abstract/IWordRepository.dart' as _i7;
import 'GameBL/Common/BalanceController.dart' as _i4;
import 'GameBL/Common/TimerController.dart' as _i6;
import 'GameBL/Common/WordInputController.dart' as _i12;
import 'GameBL/Common/WordRepository.dart' as _i8;
import 'GameBL/DI/Module.dart' as _i14;
import 'GameBL/TimeChallenge/RocketChallengeConfig.dart' as _i9;
import 'GameBL/TimeChallenge/TimeGameController.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.IBalanceController>(_i4.BalanceController());
  gh.singleton<_i5.ITimerController>(_i6.TimerController());
  gh.factory<_i7.IWordRepository>(() => _i8.WordRepository());
  gh.factory<_i9.RocketChallengeConfig>(() => _i9.RocketChallengeConfig());
  gh.factoryAsync<_i10.SharedPreferences>(() => registerModule.prefs);
  gh.singleton<_i11.IWordInputController>(
      _i12.WordInputController(wordRepository: get<_i7.IWordRepository>()));
  gh.singleton<_i13.TimeGameController>(_i13.TimeGameController(
      wordInputController: get<_i11.IWordInputController>(),
      timerController: get<_i5.ITimerController>(),
      challengeConfig: get<_i9.RocketChallengeConfig>(),
      balanceController: get<_i3.IBalanceController>()));
  return get;
}

class _$RegisterModule extends _i14.RegisterModule {}
