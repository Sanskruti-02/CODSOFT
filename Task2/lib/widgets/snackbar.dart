import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.deepPurple,
      content: Text(content),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
