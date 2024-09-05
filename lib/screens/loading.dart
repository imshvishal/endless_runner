import 'package:endless_runner/game/config.dart';
import 'package:endless_runner/screens/utils/styles.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/flame.png"),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Made with flutter flame game engine",
                style: Styles.textStyle.copyWith(fontSize: 20),
              ),
              Text(
                GameConfig.gameName,
                style: Styles.textStyle.copyWith(fontSize: 20),
              ),
              Text(
                "@Vishal - BCA 3rd Yr (26567)",
                style: Styles.textStyle.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
