import 'package:flutter/material.dart';
import 'package:quick_tap/router.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
  
}

class _GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
  final router = goRouter();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blue[300],
      )
    );
  }
}