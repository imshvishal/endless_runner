import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OverlayScreen extends StatelessWidget {
  final Widget body;
  const OverlayScreen({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(200),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    double iconSize = 30;
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Vishal Kumar',
                            style: TextStyle(
                                color: Colors.brown,
                                fontFamily: "Detail",
                                fontSize: 30),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'CIMAGE College',
                            style: TextStyle(
                                color: Colors.brown, fontFamily: "Detail"),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'BCA-PPU-452-B3-3rd Yr',
                            style: TextStyle(
                                color: Colors.brown, fontFamily: "Detail"),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'Made with Flame Game Engine (Flutter)',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: "Detail",
                                fontSize: 10),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Image.asset(
                                  "assets/images/socials/browser.png",
                                  height: iconSize,
                                  width: iconSize,
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse("https://krvishal.xyz"));
                                },
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/images/socials/instagram.png",
                                  height: iconSize,
                                  width: iconSize,
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      "https://instagram.com/imshvishal"));
                                },
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/images/socials/linkedin.png",
                                  height: iconSize,
                                  width: iconSize,
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      "https://linkedin.com/in/imshvishal"));
                                },
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/images/socials/github.png",
                                  height: iconSize,
                                  width: iconSize,
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      "https://github.com/imshvishal"));
                                },
                              ),
                              if (!kIsWeb)
                                GestureDetector(
                                  child: Image.asset(
                                    "assets/images/socials/share.png",
                                    height: iconSize,
                                    width: iconSize,
                                  ),
                                  onTap: () {
                                    var platform = Platform.operatingSystem;
                                    launchUrl(Uri.parse(
                                        "https://krvishal.xyz/hurdle_escape_game_$platform"));
                                  },
                                )
                            ],
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.info,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: body,
    );
  }
}
