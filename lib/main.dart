import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:kanyimax/src/app/app.dart';
import 'package:kanyimax/src/app/generated/locator/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  runApp(KanyimaxApp());
}

class KanyimaxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kanyimax",
      home: App(),
    );
  }
}
