import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:walot/components/asteroid.dart';

class WaveManager extends Component with HasGameReference<FlameGame> {
  final Random _random = Random();
  double timeBetweenWaves = 5.0;
  double timeSinceLastWave = 0;
  int enemiesPerWave = 3;
  int waveCount = 0;
  @override
  void update(double dt) {
    timeSinceLastWave += dt;
    if (timeSinceLastWave >= timeBetweenWaves) {
      timeSinceLastWave = 0;
      waveCount += 1;
      for (int i = 0; i < (enemiesPerWave + waveCount) * 2; i++) {
        final delay = i * 0.3;
        Future.delayed(Duration(milliseconds: (delay * 1000).toInt()), () {
          final spawn = _randomOffsetOutsideGame();
          final direction = _randomDirection();
          final asteroid = Asteroid(position: spawn, direction: direction);
          game.add(asteroid);
        });
      }
    }
  }

  Vector2 _randomOffsetOutsideGame() {
    final width = game.size.x;
    final height = game.size.y;
    final edge = _random.nextInt(4);
    switch (edge) {
      case 0:
        return Vector2(_random.nextDouble() * width, -50);
      case 1:
        return Vector2(width + 50, _random.nextDouble() * height);
      case 2:
        return Vector2(_random.nextDouble() * width, height + 50);
      default:
        return Vector2(-50, _random.nextDouble() * height);
    }
  }

  Vector2 _randomDirection() {
    return Vector2(
      _random.nextDouble() * 2 - 1,
      _random.nextDouble() * 2 - 1,
    ).normalized();
  }
}
