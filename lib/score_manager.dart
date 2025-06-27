import 'package:flame/components.dart';

class ScoreManager extends Component {
  int score = 0;

  void addPoints(int value) {
    score += value;
  }

  void deductPoint() {
    score -= 1;
  }
}
