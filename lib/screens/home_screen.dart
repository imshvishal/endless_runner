import 'dart:io';

import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:endless_runner/screens/screen.dart';
import 'package:endless_runner/screens/utils/styles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final EndlessRunner game;
  const HomeScreen({super.key, required this.game});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double hscore = 0;
  int coins = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        hscore = (prefs.getDouble("hscore") ?? 0);
        coins = prefs.getInt("coins") ?? 0;
      });
      widget.game.world.highScore = hscore;
      widget.game.world.coins = coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayScreen(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              GameConfig.gameName,
              textAlign: TextAlign.center,
              style: Styles.textStyle.copyWith(
                  color: const Color.fromARGB(255, 106, 212, 109),
                  fontSize: 80),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: Styles.buttonStyle,
                  onPressed: () {
                    if (kIsWeb) FlameAudio.bgm.play(AudioAsset.gameMusic);
                    FlameAudio.play(AudioAsset.buttonPress);
                    widget.game.overlays.remove("mainMenu");
                    widget.game.world.restart();
                    widget.game.resumeEngine();
                  },
                  child: const Text("Start Game"),
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
                    child: const Text(
                      "Exit",
                    ),
                  )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "High Score: ${hscore.toInt()}",
                  style: Styles.textStyle,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Coins: $coins",
                  style: Styles.textStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
