import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:endless_runner/game/components/background.dart';
import 'package:endless_runner/game/components/character.dart';
import 'package:endless_runner/game/components/coin.dart';
import 'package:endless_runner/game/components/ghost_power_up.dart';
import 'package:endless_runner/game/components/ground.dart';
import 'package:endless_runner/game/components/hurdles.dart';
import 'package:endless_runner/game/components/plane_power_up.dart';
import 'package:endless_runner/game/components/scoring.dart';
import 'package:endless_runner/game/config.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndlessRunner extends FlameGame<EndlessRunnerWorld>
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  EndlessRunner()
      : super(
          world: EndlessRunnerWorld(),
        );

  void gameOver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    world.highScore =
        world.score > world.highScore ? world.score : world.highScore;
    prefs.setDouble("hscore", world.highScore);
    prefs.setInt("coins", world.coins);
    pauseEngine();
    overlays.add("gameOver");
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      if (world.isBeingPlayed) resumeEngine();
      FlameAudio.bgm.resume();
    } else {
      super.lifecycleStateChange(state);
    }
  }
}

class EndlessRunnerWorld extends World with HasGameRef, TapCallbacks {
  late Character player;
  late Timer _coinSpawnTimer, _hurdleSpawnTimer, _powerUpSpawnTimer;
  final Random _random = Random();
  double score = 0, highScore = 0;
  int coins = 0;
  bool isBeingPlayed = false;
  final double _oldSpeed = GameConfig.gameSpeed;
  @override
  FutureOr<void> onLoad() async {
    if (!kIsWeb) FlameAudio.bgm.play(AudioAsset.gameMusic);
    await game.images.loadAllImages();
    add(BackGround());
    add(Ground());
    add(Scores());
    add(player = Character());
    _coinSpawnTimer =
        Timer(5, repeat: true, onTick: _spawnCoins, autoStart: false);
    _hurdleSpawnTimer =
        Timer(1.5, repeat: true, onTick: _spawnHurdles, autoStart: false);
    _powerUpSpawnTimer =
        Timer(14, repeat: true, onTick: _spawnPowerUp, autoStart: false);
    return super.onLoad();
  }

  void _spawnHurdles() {
    if (_random.nextBool()) add(Hurdles());
  }

  void _spawnCoins() {
    for (int i = 0; i <= _random.nextInt(10); i++) {
      add(
        Coin(
          position: Vector2(game.size.x + (i * 50),
              game.size.y - GameConfig.groundheight - 40),
        ),
      );
    }
  }

  void _spawnPowerUp() {
    var powerUps = [PlanePowerUp(), GhostPowerUp()];
    if (_random.nextBool()) add(powerUps[_random.nextInt(powerUps.length)]);
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.jump();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    _coinSpawnTimer.update(dt);
    _hurdleSpawnTimer.update(dt);
    _powerUpSpawnTimer.update(dt);
    removeComponentToClean(without: 20);
    super.update(dt);
  }

  void restart() {
    removeComponentToClean();
    _coinSpawnTimer.start();
    _hurdleSpawnTimer.start();
    _powerUpSpawnTimer.start();
    player.reset();
    GameConfig.gameSpeed = _oldSpeed;
    isBeingPlayed = true;
    score = 0;
  }

  void removeComponentToClean({int without = 0}) {
    var coins = children.whereType<Coin>();
    var hurdles = children.whereType<Hurdles>();
    var planePowerUps = children.whereType<PlanePowerUp>();
    var invisiblePowerUp = children.whereType<GhostPowerUp>();
    coins.take(max(coins.length - without, 0)).forEach((coin) {
      coin.removeFromParent();
    });
    hurdles.take(max(hurdles.length - without, 0)).forEach((hurdle) {
      hurdle.removeFromParent();
    });
    planePowerUps
        .take(max(planePowerUps.length - without, 0))
        .forEach((powerUp) {
      powerUp.removeFromParent();
    });
    invisiblePowerUp
        .take(max(invisiblePowerUp.length - without, 0))
        .forEach((powerUp) {
      powerUp.removeFromParent();
    });
  }
}
