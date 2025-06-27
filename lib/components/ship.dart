import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:walot/components/bullet.dart';

class Ship extends PositionComponent with HasGameReference<FlameGame> {
  double fireRate = 0.1;
  double fireCooldown = 0.0;
  Vector2? fireDirection;

  Ship({required Vector2 position})
    : super(position: position, size: Vector2(20, 20), anchor: Anchor.center);

  @override
  void update(double dt) {
    fireCooldown -= dt;
    if (fireDirection != null && fireCooldown <= 0) {
      final bulletStartPos = position;
      game.add(Bullet(position: bulletStartPos, velocity: fireDirection!));
      fireCooldown = fireRate;
    }
  }

  void aimAt(Vector2 screenPosition) {
    final direction = (screenPosition - position).normalized();
    fireDirection = direction;
    angle = atan2(direction.y, direction.x);
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFFFFFFF);
    final path = Path();
    path.moveTo(5, 0);
    path.lineTo(-15, -10);
    path.lineTo(-15, 10);
    path.close();
    canvas.drawPath(path, paint);
  }
}
