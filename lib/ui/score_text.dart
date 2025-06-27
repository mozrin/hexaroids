import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../score_manager.dart';

class ScoreText extends TextComponent with HasGameReference<FlameGame> {
  late final ScoreManager score;

  @override
  Future<void> onLoad() async {
    score = parent!.children.whereType<ScoreManager>().first;
    position = Vector2(10, 10);
    anchor = Anchor.topLeft;
    textRenderer = TextPaint(
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Score: ${score.score}';
  }
}
