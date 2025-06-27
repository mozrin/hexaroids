import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:walot/score_manager.dart';
import 'package:walot/components/ship.dart';
import 'package:walot/components/explosion.dart';
import 'package:walot/components/shield.dart';

class Asteroid extends PositionComponent with HasGameReference<FlameGame> {
  final double speed = 40;
  double health = 50;
  late Vector2 velocity;
  bool hasSplit;

  Asteroid({
    required Vector2 position,
    required Vector2 direction,
    this.hasSplit = false,
  }) : super(position: position, size: Vector2(30, 30)) {
    velocity = direction.normalized() * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    final otherAsteroids = parent?.children.whereType<Asteroid>().toList();
    if (otherAsteroids != null) {
      for (final other in otherAsteroids) {
        if (other == this) continue;

        if (toRect().overlaps(other.toRect())) {
          final Vector2 thisCenter = position + size / 2;
          final Vector2 otherCenter = other.position + other.size / 2;

          final Vector2 normal = (thisCenter - otherCenter).normalized();

          velocity = velocity - normal * 2 * velocity.dot(normal);
          velocity = velocity.normalized() * speed;
        }
      }
    }

    final ship = parent?.children.whereType<Ship>().firstOrNull;
    if (ship != null) {
      Shield? outermostHitShield;
      double maxRadius = -1;
      for (final shield in game.children.whereType<Shield>()) {
        if (!shield.hit &&
            position.distanceTo(ship.position) <= shield.radius) {
          if (shield.radius > maxRadius) {
            maxRadius = shield.radius;
            outermostHitShield = shield;
          }
        }
      }
      if (outermostHitShield != null) {
        final n = (position - ship.position).normalized();
        velocity = velocity - n * 2 * velocity.dot(n);
        velocity = velocity.normalized() * speed;
        outermostHitShield.hit = true;
      }

      if (toRect().overlaps(ship.toRect())) {
        game.pauseEngine();
        return;
      }
    }

    if (health <= 0) {
      if (!hasSplit) {
        final rand = Random();
        for (int i = 0; i < 2; i++) {
          final dir =
              Vector2(
                rand.nextDouble() * 2 - 1,
                rand.nextDouble() * 2 - 1,
              ).normalized();
          final fragmentPosition = position.clone() + dir * 10;
          final fragment = Asteroid(
            position: fragmentPosition,
            direction: dir,
            hasSplit: true,
          );
          fragment.size.setFrom(size.clone()..scale(0.5));
          parent?.add(fragment);
        }
      }

      final manager = parent?.children.whereType<ScoreManager>().firstOrNull;
      final isInCircle =
          ship != null && position.distanceTo(ship.position) < 100;
      manager?.addPoints(isInCircle ? 10 : 20);
      parent?.add(Explosion(position: position.clone()));
      removeFromParent();
    }
  }

  void takeDamage(double amount) {
    health -= amount;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFE53935);
    final path = Path();
    final cx = size.x / 2;
    final cy = size.y / 2;
    final r = size.x / 2;
    for (int i = 0; i < 6; i++) {
      final angle = pi / 3 * i;
      final x = cx + r * cos(angle);
      final y = cy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}
