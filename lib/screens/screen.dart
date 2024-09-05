import 'dart:io';

import 'package:endless_runner/screens/utils/config.dart';
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
                            children:
                                List.of(AppConfig.socials.entries.map((entry) {
                              return GestureDetector(
                                child: Image.asset(
                                  "assets/images/socials/${entry.key}.png",
                                  height: 30,
                                  width: 30,
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(entry.value));
                                },
                              );
                            })),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(fontFamily: "Detail"),
                          ),
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
