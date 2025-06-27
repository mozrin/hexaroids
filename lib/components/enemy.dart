import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import '../score_manager.dart';
import 'tower.dart';
import 'explosion.dart';

class Enemy extends PositionComponent with HasGameRef<FlameGame> {
  double speed = 50;
  double health = 100;
  late Vector2 velocity;
  bool hasSplit;

  Enemy({
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

    final tower = parent?.children.whereType<Tower>().firstOrNull;
    if (tower != null && toRect().overlaps(tower.toRect())) {
      gameRef.pauseEngine();
      return;
    }

    if (health <= 0) {
      final manager = parent?.children.whereType<ScoreManager>().firstOrNull;
      final isInCircle =
          tower != null && position.distanceTo(tower.position) < 100;
      if (isInCircle) {
        manager?.addPoints(10);
      } else {
        manager?.addPoints(20);
      }
      parent?.add(Explosion(position: position.clone()));
      removeFromParent();
    }
  }

  void takeDamage(double amount) {
    if (!hasSplit) {
      final rand = Random();
      for (int i = 0; i < 2; i++) {
        final dir =
            Vector2(
              rand.nextDouble() - 0.5,
              rand.nextDouble() - 0.5,
            ).normalized();
        final fragment = Enemy(
          position: position.clone(),
          direction: dir,
          hasSplit: true,
        );
        fragment.size.setFrom(size.clone()..scale(0.5));
        fragment.speed = speed;
        gameRef.add(fragment);
      }
      removeFromParent();
    } else {
      health = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFE53935);
    canvas.drawRect(size.toRect(), paint);
  }
}
