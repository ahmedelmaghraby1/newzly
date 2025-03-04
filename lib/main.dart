import 'package:flutter/material.dart';
import 'package:newzly/core/source/app.dart';
import 'package:newzly/core/source/app_initialization.dart';

Future<void> main() async {
  await initializeApp();
  runApp(const Newzly());
}
