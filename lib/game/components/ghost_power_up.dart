import 'dart:async';

import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GhostPowerUp extends SpriteComponent with HasGameRef<EndlessRunner> {
  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.bottomCenter;
    size = Vector2(64, 64);
    position.x = game.size.x;
    sprite = Sprite(game.images.fromCache("foreground/powerups/ghost.png"));
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  @override
  void onGameResize(Vector2 size) {
    position.y = game.size.y / 2 - GameConfig.groundheight - 30;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    position.x -= GameConfig.gameSpeed * dt;
    super.update(dt);
  }
}
