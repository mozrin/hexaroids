import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/enemy.dart';

class EnemySpawner extends Component with HasGameRef<FlameGame> {
  final Random _random = Random();
  double timer = 0;
  double interval = 2.0;

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer >= interval) {
      timer = 0;
      final spawnPos = Vector2(0, 220);
      final direction = Vector2(
        _random.nextDouble() - 0.5,
        _random.nextDouble() - 0.5,
      );
      gameRef.add(Enemy(position: spawnPos, direction: direction));
    }
  }
}
