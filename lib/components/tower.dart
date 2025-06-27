import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'bullet.dart';

class Tower extends PositionComponent with HasGameReference<FlameGame> {
  double fireRate = 0.1;
  double fireCooldown = 0.0;
  Vector2? fireDirection;

  Tower({required Vector2 position})
    : super(position: position, size: Vector2(40, 40));

  @override
  void update(double dt) {
    fireCooldown -= dt;

    if (fireDirection != null && fireCooldown <= 0) {
      game.add(Bullet(position: position.clone(), velocity: fireDirection!));
      fireCooldown = fireRate;
    }
  }

  void aimAt(Vector2 screenPosition) {
    final direction = (screenPosition - position).normalized();
    fireDirection = direction;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF1E88E5);
    canvas.drawRect(size.toRect(), paint);
  }
}
