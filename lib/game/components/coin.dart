import 'dart:async';

import 'package:endless_runner/game/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Coin extends SpriteAnimationComponent with HasGameRef {
  Coin({required Vector2 position}) : super(position: position);
  @override
  FutureOr<void> onLoad() async {
    add(CircleHitbox(collisionType: CollisionType.passive));
    size = Vector2(40, 40);
    anchor = Anchor.bottomLeft;
    List<Sprite> coins = [
      for (int i = 0; i <= 15; i++)
        await Sprite.load("foreground/coin/image $i.png")
    ];
    animation = SpriteAnimation.spriteList(coins, stepTime: 0.05);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.x -= GameConfig.gameSpeed * dt;
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    position.y = game.size.y / 2 - GameConfig.groundheight - 40;
    super.onGameResize(size);
  }
}
