import 'package:cosmo_word/Flame/Controllers/Abstract/UiControllerBase.dart';
import 'package:cosmo_word/Flame/ElementsLayoutBuilder.dart';
import 'package:flame/components.dart';
import 'package:flame/src/components/component.dart';

import '../UiComponents/InputWordParticles/InputWordParticles.dart';

class InputWordParticlesController extends UiControllerBase {

  final ElementLayoutData layoutData;
  final Vector2 directionVector;
  final int particlesCount;
  final Vector2 particleSize;
  final double durationSec;
  final double wordAxisDistributionFactor;

  late InputWordParticles _particlesControl;

  @override
  Component get rootUiControl => _particlesControl;

  InputWordParticlesController({
    required this.layoutData,
    required this.directionVector,
    required this.particlesCount,
    required this.particleSize,
    required this.durationSec,
    required this.wordAxisDistributionFactor,
  });

  @override
  Future initAsync() async {
    _particlesControl = InputWordParticles(
      zonePosition: layoutData.position,
      zoneSize: layoutData.size,
      directionVector: directionVector,
      zoneAnchor: layoutData.anchor,
      particlesCount: particlesCount,
      particleSize: particleSize,
      durationSec: durationSec,
      wordAxisDistributionFactor: wordAxisDistributionFactor
    );
  }

  void showParticles(int particlesCount){
    _particlesControl.showParticles(particlesCount);
  }
}