import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/quick_tap_game.dart';

enum ShapeType { triangle, square, circle, rectangle }

class GameShape extends PositionComponent with HasGameReference<QuickTapGame> {
  final ShapeType shapeType;
  final Color color;

  GameShape({
    required Vector2 position,
    required double size,
    required this.shapeType,
    this.color = Colors.blue,
  }) : super(position: position, size: Vector2.all(size));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = color;

    switch (shapeType) {
      case ShapeType.triangle:
        final path = Path()
          ..moveTo(size.x / 2, 0)          
          ..lineTo(0, size.y)             
          ..lineTo(size.x, size.y)        
          ..close();
        canvas.drawPath(path, paint);
        break;

      case ShapeType.square:
        canvas.drawRect(size.toRect(), paint);
        break;

      case ShapeType.circle:
        canvas.drawCircle(
          Offset(size.x / 2, size.y / 2), 
          size.x / 2, 
          paint,
        );
        break;

      case ShapeType.rectangle:
        final rect = Rect.fromLTWH(0, size.y * 0.25, size.x, size.y * 0.5);
        canvas.drawRect(rect, paint);
        break;
    }
  }
}