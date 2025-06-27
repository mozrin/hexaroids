import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:walot/components/ship.dart';
import 'package:flutter/material.dart';

class Shield extends Component with HasGameReference<FlameGame> {
  final Ship ship;
  final double radius;
  final Color color;
  bool hit = false;
  double _hitTimer = 0;
  final double _flickerDuration = 0.2;
  final double _vanishDelay = 0.3;

  Shield({required this.ship, required this.radius, required this.color});

  @override
  void update(double dt) {
    if (hit) {
      _hitTimer += dt;
      if (_hitTimer >= _vanishDelay) {
        removeFromParent();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    Color effectiveColor = color;
    if (hit) {
      if (_hitTimer < _flickerDuration) {
        if ((_hitTimer * 20).floor().isEven) {
          effectiveColor = Colors.red;
        } else {
          effectiveColor = color;
        }
      } else {
        effectiveColor = Colors.transparent;
      }
    }

    final paint =
        Paint()
          ..color = effectiveColor
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(ship.position.x, ship.position.y), radius, paint);
  }
}
