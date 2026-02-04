import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:quick_tap/game/level.dart';
import 'package:flame/components.dart';

class GameHelpers {
  static final Random _random = Random();

  // Lista di colori centralizzata
  static const List<Color> palette = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.cyan,
    Colors.black,
    Colors.brown,
    Colors.teal,
    Colors.lime,
    Colors.indigo,
    Colors.amber,
    Colors.deepOrange,
    Colors.lightBlue,
    Colors.deepPurple,
    Colors.lightGreen,
    Colors.grey,
    Colors.blueGrey,
  ];

  /// Restituisce una dimensione casuale tra [min] e [max] con uno [step] specifico
  static double randomSize({double min = 50, double max = 250, double step = 10}) {
    int iterations = ((max - min) / step).floor();
    return min + (_random.nextInt(iterations + 1) * step);
  }

  /// Restituisce un colore casuale dalla palette
  static Color randomColor() {
    return palette[_random.nextInt(palette.length)];
  }

  /// Restituisce un valore double casuale (utile per velocità o rotazione)
  static double randomRange(double min, double max) {
    return min + (_random.nextDouble() * (max - min));
  }

  static List<GameShapeConfig> generateLevelShapes({
    required int totalShapes,
    required ShapeType targetType,
    required Color targetColor,
    int minWinningShapes = 1,
  }) {
    List<GameShapeConfig> configs = [];

    for (int i = 0; i < totalShapes; i++) {
      bool forceWin = i < minWinningShapes; // Le prime N forme saranno vincenti
      
      // Se è una forma vincente, usiamo i target. 
      // Altrimenti, usiamo valori casuali (con un piccolo controllo per non ripetere il target)
      ShapeType type = forceWin ? targetType : _getRandomTypeExcept(targetType);
      Color color = forceWin ? targetColor : _getRandomColorExcept(targetColor);

      configs.add(
        GameShapeConfig(
          type: type,
          color: color,
          size: randomSize(),
          // Posizione casuale (da calcolare in base alla dimensione del tuo mondo)
          position: Vector2(randomRange(-150, 150), randomRange(-250, 250)),
          velocity: Vector2(randomRange(-100, 100), randomRange(-100, 100)),
          rotationSpeed: randomRange(0, 3),
        ),
      );
    }

    configs.shuffle(); // Mischiamo la lista così le vincenti non sono tutte all'inizio
    return configs;
  }

  // Helper privati per evitare duplicati del target
  static ShapeType _getRandomTypeExcept(ShapeType except) {
    final types = ShapeType.values.where((t) => t != except).toList();
    return types[_random.nextInt(types.length)];
  }

  static Color _getRandomColorExcept(Color except) {
    final colors = palette.where((c) => c.toARGB32() != except.toARGB32()).toList();
    return colors[_random.nextInt(colors.length)];
  }
}