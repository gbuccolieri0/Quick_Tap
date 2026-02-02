import 'package:flutter/material.dart';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:flame/components.dart';


class Level {
  final int number;
  final String instruction;
  final List<GameShapeConfig> shapes;
  final bool Function(GameShape) isWinCondition; // Una funzione per decidere se il tap è corretto

  Level({
    required this.number,
    required this.instruction,
    required this.shapes,
    required this.isWinCondition,
  });
}

// Una piccola classe di supporto per configurare le forme
class GameShapeConfig {
  final ShapeType type;
  final Color color;
  final Vector2 position;
  final Vector2 velocity;

  GameShapeConfig({
    required this.type,
    required this.color,
    required this.position,
    required this.velocity,
  });
}