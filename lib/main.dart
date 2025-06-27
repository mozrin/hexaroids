import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:walot/walot_game.dart';

void main() {
  final game = WalotGame();
  runApp(
    GestureDetector(
      onTapDown: (TapDownDetails details) {
        final pos = details.localPosition;
        game.handleTapDown(Vector2(pos.dx, pos.dy));
      },
      onTapUp: (TapUpDetails details) {
        game.handleTapUp();
      },
      onTapCancel: () {
        game.handleTapUp();
      },
      child: GameWidget(game: game),
    ),
  );
}
