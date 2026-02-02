import 'level.dart';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class LevelData {
  Level getLevel(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return Level(
          number: 1,
          instruction: "NON TOCCARE I QUADRATI!",
          isWinCondition: (shape) => shape.shapeType != ShapeType.square,
          shapes: [
            GameShapeConfig(type: ShapeType.triangle, color: Colors.blue, position: Vector2(100, 100), velocity: Vector2(100, 100)),
            GameShapeConfig(type: ShapeType.square, color: Colors.red, position: Vector2(200, 100), velocity: Vector2(-50, 150)),
            GameShapeConfig(type: ShapeType.square, color: Colors.green, position: Vector2(50, 300), velocity: Vector2(80, -40)),
          ],
        );
      default:
        throw Exception("Livello non trovato");
    }
  }
}