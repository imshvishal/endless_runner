import 'package:flutter/material.dart';

void showYesNoPromot(BuildContext context, String prompt, Function onYes) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [Text(prompt)],
          ),
        );
      });
}
