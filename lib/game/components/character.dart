import 'dart:async';

import 'package:endless_runner/game/components/ghost_power_up.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';

import 'package:endless_runner/game/components/coin.dart';
import 'package:endless_runner/game/components/hurdles.dart';
import 'package:endless_runner/game/components/plane_power_up.dart';
import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';

enum CharacterState { idle, walk, run, jump, dead }

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}

class Character extends SpriteAnimationGroupComponent
    with HasGameRef<EndlessRunner>, CollisionCallbacks, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation walkAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation deadAnimation;
  final int spriteOffset = 15;
  bool isJumping = false;
  late Timer invisible;
  bool isInvisible = true;
  @override
  FutureOr<void> onLoad() {
    invisible = Timer(2, onTick: () {
      isInvisible = false;
    }, repeat: false);
    _loadAllAnimations();
    priority = 1;
    anchor = Anchor.bottomLeft;
    size = Vector2(200, 180);
    add(
      RectangleHitbox.relative(
        Vector2(0.3, 0.7),
        parentSize: size,
        position: Vector2(20, 0),
      ),
    );

    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position.x = -game.size.x / 2 + 50;
    position.y = game.size.y / 2 - GameConfig.groundheight + spriteOffset;
    super.onGameResize(size);
  }

  void _loadAllAnimations() async {
    animations = {
      CharacterState.idle: await _createAnimation(CharacterState.idle),
      CharacterState.run: await _createAnimation(CharacterState.run),
      CharacterState.walk: await _createAnimation(CharacterState.walk),
      CharacterState.jump: await _createAnimation(CharacterState.jump),
      CharacterState.dead: await _createAnimation(CharacterState.dead)
    };
    current = CharacterState.run;
  }

  Future<SpriteAnimation> _createAnimation(CharacterState state) async {
    var images = [
      for (int i = 1; i <= 15; i++)
        Flame.images.fromCache("character/${state.name.toCapitalized} ($i).png")
    ];
    var spriteAnimation = SpriteAnimation.spriteList(
        images.map((img) => Sprite(img)).toList(),
        stepTime: 0.04,
        loop: state == CharacterState.run);
    return spriteAnimation;
  }

  @override
  void update(double dt) {
    if (game.world.isBeingPlayed) {
      GameConfig.gameSpeed += 0.001;
      game.world.score += dt * 0.1 * GameConfig.gameSpeed;
    }
    opacity = isInvisible ? 0.5 : 1;
    if (current == CharacterState.jump) {
      position.y -= 200 * dt;
    } else {
      if (position.y <
          game.size.y / 2 - GameConfig.groundheight + spriteOffset) {
        position.y += 200 * 1.5 * dt;
      } else {
        isJumping = false;
      }
    }
    invisible.update(dt);
    super.update(dt);
  }

  void jump() {
    var oldState = current;
    if (isJumping || current == CharacterState.dead) return;
    isJumping = true;
    current = CharacterState.jump;
    animationTicker!.completed.then((val) {
      current = oldState;
    });
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (!game.world.isBeingPlayed) return;
    if (other is Hurdles && !isInvisible) {
      FlameAudio.play(AudioAsset.gameOver, volume: 0.6);
      current = CharacterState.dead;
      game.world.isBeingPlayed = false;
      animationTicker!.completed.then((val) {
        game.gameOver();
      });
    } else if (other is Coin) {
      other.removeFromParent();
      FlameAudio.play(AudioAsset.coinReceived, volume: 0.5);
      game.world.coins += 1;
    } else if (other is PlanePowerUp) {
      FlameAudio.play(AudioAsset.plane);
      other.removeFromParent();
      removeFromParent();
      var powerUp = PlanePowerUp(asPlayer: true);
      game.world.add(powerUp);
    } else if (other is GhostPowerUp) {
      other.removeFromParent();
      isInvisible = true;
      invisible = Timer(10, onTick: () {
        isInvisible = false;
      }, repeat: false);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isSpaceClicked = keysPressed.contains(LogicalKeyboardKey.space);
    if (isSpaceClicked) {
      jump();
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void reset() {
    current = CharacterState.run;
  }
}
