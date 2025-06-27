import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:walot/components/asteroid.dart';
import 'package:walot/score_manager.dart';

class Bullet extends PositionComponent {
  Vector2 velocity;
  double speed = 200;
  double damage = 50;

  Bullet({required Vector2 position, required this.velocity})
    : super(position: position, size: Vector2(4, 4));

  @override
  Future<void> onLoad() async {
    final manager = parent?.children.whereType<ScoreManager>().firstOrNull;
    manager?.deductPoint();
  }

  @override
  void update(double dt) {
    position += velocity * speed * dt;
    final enemies = parent?.children.whereType<Asteroid>();
    if (enemies != null) {
      for (final asteroid in enemies) {
        if (toRect().overlaps(asteroid.toRect())) {
          asteroid.takeDamage(damage);
          removeFromParent();
          break;
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
