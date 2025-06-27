import 'package:flame/game.dart';
import 'components/shield.dart';
import 'components/ship.dart';
import 'wave_manager.dart';
import 'score_manager.dart';
import 'ui/score_text.dart';
import 'package:flutter/material.dart';
import 'package:walot/components/center_dot.dart';

class WalotGame extends FlameGame {
  late final ScoreManager score;
  late final Ship ship;

  final List<Color> shieldColors = [
    const Color(0xFF5AA2EF),
    const Color(0xFF4A89CF),
    const Color(0xFF3A70AF),
    const Color(0xFF2A578F),
    const Color(0xFF1A3E6F),
  ];

  @override
  Future<void> onLoad() async {
    score = ScoreManager();
    add(score);
    add(ScoreText());

    final c = Vector2(size.x / 2, size.y / 2);
    ship = Ship(position: c);
    ship.priority = 10;
    add(ship);

    add(
      CenterDot()
        ..position = c
        ..priority = 20,
    );

    for (int i = 1; i <= 5; i++) {
      final currentRadius = i * 20.0;
      final shieldColor = shieldColors[i - 1];
      final shield = Shield(
        ship: ship,
        radius: currentRadius,
        color: shieldColor,
      );
      shield.priority = 10 - i;
      add(shield);
    }
    add(WaveManager());
  }

  void handleTap(Vector2 p) {
    ship.aimAt(p);
  }
}
