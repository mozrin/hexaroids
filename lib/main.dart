import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:walot/walot_game.dart';

void main() {
  final game = WalotGame();
  runApp(
    GestureDetector(
      onTapDown: (TapDownDetails details) {
        final pos = details.localPosition;
        game.handleTap(Vector2(pos.dx, pos.dy));
      },
      child: GameWidget(game: game),
    ),
  );
}
