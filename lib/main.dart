import 'dart:async';
import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/game/hurdle_escape.dart';
import 'package:endless_runner/screens/game_over.dart';
import 'package:endless_runner/screens/home_screen.dart';
import 'package:endless_runner/screens/loading.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// import 'dart:html';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlameAudio.audioCache.loadAll(AudioAsset.getAllAudioAssets());
  await WakelockPlus.enable();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  FlameAudio.bgm.initialize();
  runApp(const HomeGameWidget());
}

class HomeGameWidget extends StatelessWidget {
  const HomeGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: EndlessRunner(),
        initialActiveOverlays: const ["loading"],
        overlayBuilderMap: {
          "loading": (context, game) {
            Timer(const Duration(seconds: 3), () {
              (game as EndlessRunner).overlays.remove("loading");
              game.overlays.add("mainMenu");
            });
            return const LoadingScreen();
          },
          "mainMenu": (context, game) {
            return HomeScreen(game: game as EndlessRunner);
          },
          "gameOver": (context, game) {
            return GameOverScreen(game: game as EndlessRunner);
          }
        },
      ),
    );
  }
}
