import 'package:flutter/material.dart';

class Styles {
  static var textStyle =
      const TextStyle(fontFamily: "Game", color: Colors.white, fontSize: 30);
  static var buttonStyle = OutlinedButton.styleFrom(
    textStyle: textStyle.copyWith(fontSize: 30, fontFamily: "Detail"),
    side: const BorderSide(color: Colors.green, width: 3),
    foregroundColor: Colors.brown,
  );
}
