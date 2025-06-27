import 'package:flame/game.dart';
import 'components/tower.dart';
import 'wave_manager.dart';
import 'score_manager.dart';
import 'ui/score_text.dart';

class WalotGame extends FlameGame {
  late final ScoreManager score;
  late final Tower tower;

  @override
  Future<void> onLoad() async {
    score = ScoreManager();
    add(score);
    add(ScoreText());
    final c = Vector2(size.x / 2, size.y / 2);
    tower = Tower(position: c);
    add(tower);
    add(WaveManager());
  }

  void handleTap(Vector2 p) {
    tower.aimAt(p);
  }
}
