import 'level.dart';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:quick_tap/game/utils/game_helpers.dart';

class LevelData {
  Level getLevel(int levelNumber) {
    switch (levelNumber) {
      case 1:
        return Level(
          number: 1,
          instruction: "NON TOCCARE I QUADRATI!",
          isWinCondition: (shape) => shape.shapeType != ShapeType.square,
          shapes: [
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.triangle, color: GameHelpers.randomColor(), position: Vector2(100, 100), velocity: Vector2(300, 300), rotationSpeed: 1),
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.square, color: GameHelpers.randomColor(), position: Vector2(200, 100), velocity: Vector2(-50, 150)),
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.square, color: GameHelpers.randomColor(), position: Vector2(50, 300), velocity: Vector2(80, -40)),
          ],
        );
      case 2:
        return Level(
          number: 2,
          instruction: "NON TOCCARE I TRINAGOLI GiALLI!",
          isWinCondition: (shape) =>  !(shape.shapeType == ShapeType.triangle && 
                                 shape.color.toARGB32() == Colors.yellow.toARGB32()),
          shapes: [
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.triangle, color: Colors.yellow, position: Vector2(100, 100), velocity: Vector2(300, 300), rotationSpeed: 1),
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.triangle, color: GameHelpers.randomColor(), position: Vector2(200, 100), velocity: Vector2(-50, 150)),
            GameShapeConfig(size: GameHelpers.randomSize(min: 50, max: 250, step: 10),type: ShapeType.square, color: GameHelpers.randomColor(), position: Vector2(50, 300), velocity: Vector2(80, -40)),
          ],
        );
      case 3:
        const targetType = ShapeType.square;
        const targetColor = Colors.green;
        
        return Level(
          number: 3,
          instruction: "TOCCA I QUADRATI VERDI!",
          isWinCondition: (shape) => 
              shape.shapeType == targetType && shape.color.toARGB32() == targetColor.toARGB32(),
          shapes: GameHelpers.generateLevelShapes(
            totalShapes: 8,      // 8 forme totali
            targetType: targetType,
            targetColor: targetColor,
            minWinningShapes: 2, // Garantiamo almeno 2 quadrati verdi
          ),
        );
      default:
        throw Exception("Livello non trovato");
    }
  }
}