import 'dart:async';

import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class Ground extends ParallaxComponent<EndlessRunner> {
  @override
  FutureOr<void> onLoad() async {
    anchor = Anchor.bottomCenter;
    parallax = await game.loadParallax(
      [ParallaxImageData("foreground/GrassMid.png")],
      fill: LayerFill.none,
      baseVelocity: Vector2(GameConfig.gameSpeed, y),
    );
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    position.y = game.size.y / 2;
    super.onGameResize(size);
  }
}
