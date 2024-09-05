import 'dart:async';

import 'package:endless_runner/game/components/character.dart';
import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';

class PlanePowerUp extends SpriteComponent
    with HasGameRef<EndlessRunner>, KeyboardHandler {
  late bool asPlayer;
  PlanePowerUp({this.asPlayer = false}) : super(anchor: Anchor.bottomCenter);
  late Timer onFinish = Timer(10, onTick: () {
    removeFromParent();
  }, autoStart: false);
  final double _oldSpeed = GameConfig.gameSpeed;
  @override
  FutureOr<void> onLoad() async {
    if (asPlayer) {
      size = Vector2(150, 75);
      anchor = Anchor.topLeft;
      GameConfig.gameSpeed *= 2;
      onFinish.start();
    } else {
      size = Vector2(80, 50);
    }
    sprite = Sprite(game.images.fromCache("foreground/powerups/plane.png"));
    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    onFinish.update(dt);
    if (game.world.isBeingPlayed) {
      game.world.score += dt * 0.3 * GameConfig.gameSpeed;
    }
    if (!asPlayer) {
      position.x -= GameConfig.gameSpeed * dt;
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    if (asPlayer) {
      position = Vector2(-size.x / 2 + 100, -size.y / 2 + 50);
    } else {
      position =
          Vector2(game.size.x, game.size.y / 2 - GameConfig.groundheight - 40);
    }
    super.onGameResize(size);
  }

  @override
  void removeFromParent() {
    GameConfig.gameSpeed = _oldSpeed;
    if (asPlayer) {
      var player = Character();
      game.world.player = player;
      game.world.add(player);
    }
    super.removeFromParent();
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // if (!asPlayer) return false;
    // var arrowUp = keysPressed.contains(LogicalKeyboardKey.arrowUp);
    // var arroDown = keysPressed.contains(LogicalKeyboardKey.arrowDown);
    return super.onKeyEvent(event, keysPressed);
  }
}
