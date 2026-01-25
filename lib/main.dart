import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'game_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  Flame.device.fullScreen();
  Flame.device.setPortrait(); // Set device orientation to portrait
  runApp(const GameApp());
}