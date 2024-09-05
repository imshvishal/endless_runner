import 'dart:async';

import 'package:endless_runner/game/config.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class BackGround extends ParallaxComponent {
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.center;
    parallax = await game.loadParallax([
      ParallaxImageData("background/Back.png"),
      ParallaxImageData("background/Mid2.png"),
      ParallaxImageData("background/Mid.png"),
      ParallaxImageData("background/Front.png"),
    ],
        baseVelocity: Vector2(GameConfig.gameSpeed / 1.5, y),
        velocityMultiplierDelta: Vector2(1.1, y));
    return super.onLoad();
  }
}
