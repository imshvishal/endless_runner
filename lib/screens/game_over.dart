import 'dart:io';

import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:endless_runner/screens/screen.dart';
import 'package:endless_runner/screens/utils/styles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final EndlessRunner game;
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return OverlayScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score: ${game.world.score.toInt()}",
              style: Styles.textStyle,
            ),
            Text(
              "High Score: ${game.world.highScore.toInt()}",
              style: Styles.textStyle,
            ),
            Text(
              "Coins: ${game.world.coins}",
              style: Styles.textStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: Styles.buttonStyle,
                  onPressed: () {
                    FlameAudio.play(AudioAsset.buttonPress);
                    game.world.restart();
                    game.overlays.remove("gameOver");
                    game.resumeEngine();
                  },
                  child: const Text(
                    "Restart",
                  ),
                ),
                if (!kIsWeb)
                  const SizedBox(
                    width: 20,
                  ),
                if (!kIsWeb)
                  OutlinedButton(
                    style: Styles.buttonStyle,
                    onPressed: () {
                      FlameAudio.play(AudioAsset.buttonPress);
                      exit(0);
                    },
                    child: const Text("Exit Game"),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
