import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';

class Scores extends PositionComponent with HasGameRef<EndlessRunner> {
  late TextComponent score, coins, hscore;
  @override
  FutureOr<void> onLoad() {
    var textRenderer = TextPaint(
        style: TextStyle(
            fontFamily: "Detail",
            fontSize: game.size.y * .05,
            color: const Color(0xffffffff)));
    // add(hscore = )
    add(score = TextComponent(
      text: "Score: 0",
      textRenderer: textRenderer,
    ));
    add(coins = TextComponent(
        text: "Coins: ${game.world.coins}",
        textRenderer: textRenderer,
        position: Vector2(position.x, position.y + score.height)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!game.world.isBeingPlayed) {
      position.x = game.size.x;
    } else if (game.size.x / 2 - (position.x + max(score.width, coins.width)) <
        50) {
      position.x -= 1 * dt * GameConfig.gameSpeed;
    }
    score.text = "Score: ${game.world.score.toInt()}";
    coins.text = "Coins: ${game.world.coins}";
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    // score.textRenderer.
    position.x = game.size.x;
    position.y = -game.size.y / 2 + 25;
    super.onGameResize(size);
  }
}
