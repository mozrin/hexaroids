import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CenterDot extends PositionComponent {
  CenterDot() : super(size: Vector2.all(5), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
