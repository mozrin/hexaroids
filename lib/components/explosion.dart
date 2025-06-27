import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class Explosion extends PositionComponent {
  double lifespan = 0.3;
  double timer = 0;

  Explosion({required Vector2 position})
    : super(position: position, size: Vector2.all(30));

  @override
  void update(double dt) {
    timer += dt;
    if (timer >= lifespan) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint =
        Paint()
          ..color = const Color(0x88FFFFFF)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
