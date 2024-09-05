import 'dart:async';
import 'dart:math';

import 'package:endless_runner/game/components/character.dart';
import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Hurdles extends SpriteComponent
    with HasGameRef<EndlessRunner>, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    position.x = game.size.x;
    size = Vector2(64, 64);
    var obstacaleImages = [
      "foreground/enemies/Spike_Up.png",
      "foreground/enemies/Mace.png",
      "foreground/enemies/Saw.png"
    ];
    var randomIndex = Random().nextInt(obstacaleImages.length);
    sprite = await Sprite.load(obstacaleImages[randomIndex]);
    add(
      CircleHitbox(
          collisionType: CollisionType.active,
          radius: 20,
          anchor: Anchor.center,
          position: size / 2),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= GameConfig.gameSpeed * dt;
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    position.y = game.size.y / 2 - GameConfig.groundheight - 10;
    super.onGameResize(size);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is! Character) {
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
