import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/particles.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/services.dart';

class InputWordParticles extends Component {

  final Vector2 zonePosition;
  final Vector2 zoneSize;
  final Vector2 directionVector;
  final Anchor zoneAnchor;
  final int particlesCount;
  final Vector2 particleSize;
  final double durationSec;
  final double wordAxisDistributionFactor;

  final List<Curve> particleCurves = [
    Curves.ease,
    Curves.easeInCubic,
    Curves.fastOutSlowIn,
    Curves.easeOutQuad,
    Curves.easeOutExpo,
    Curves.easeOutQuint,
    Curves.slowMiddle
  ];

  Random rnd = Random();

  late Image _particleImage;

  InputWordParticles({
    required this.zonePosition,
    required this.zoneSize,
    required this.directionVector,
    required this.zoneAnchor,
    required this.particlesCount,
    required this.particleSize,
    required this.durationSec,
    required this.wordAxisDistributionFactor,
  });

  Future<void> onLoad() async {
    await super.onLoad();

    var rect = RectangleComponent(
        size: zoneSize,
        position: zonePosition,
        paint: Paint()..color = Material.Colors.transparent
    );
    rect.anchor = zoneAnchor;
    add(rect);

    _particleImage = await Flame.images.load('widget/activeBtnBg.png');
  }

  void showParticles(int particlesCount) {
    var from = Vector2(0, 0);
    var to = Vector2(0, 0);
    if(directionVector.x == -1 && directionVector.y == -1){
      from = zonePosition + zoneSize;
      to = zonePosition;
    }
    if(directionVector.x == 1 && directionVector.y == -1){
      from = zonePosition;
      to = zonePosition+Vector2(zoneSize.x*directionVector.x, zoneSize.y*directionVector.y);
    }

    var particleSystem = ParticleSystemComponent(
      particle: Particle.generate(
          count: particlesCount*10,
          lifespan: durationSec,
          generator: (i) {
            var randomVector = (Vector2.random(rnd) - Vector2.random(rnd)) * wordAxisDistributionFactor;
            HapticFeedback.heavyImpact();
            return MovingParticle(
                from: Vector2(from.x + randomVector.x, from.y+rnd.nextInt(20)),
                to: to,
                child: ImageParticle(
                  size: particleSize,
                  image: _particleImage
                ),
                curve: particleCurves[rnd.nextInt(particleCurves.length)]
            );
          }
      ),
    );
    add(particleSystem);
  }
}