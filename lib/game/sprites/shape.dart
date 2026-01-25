import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/quick_tap_game.dart';

enum ShapeType { triangle, square, circle, oval, rectangle }

class Shape extends PositionComponent with HasGameReference<QuickTapGame>{
  final ShapeType shapeType;
  final double shapeSize;
  final Color color;
  final Paint paint; 
  final double positionX;
  final double positionY;
  final IconData? icon;

  Shape({
    required this.shapeType,
    required this.shapeSize,
    this.color = Colors.blue,
    this.positionX = 120.0,
    this.positionY = 700.0,
    IconData? icon,
  }) : icon = icon ?? _getDefaultIcon(shapeType),
       paint = Paint()..color = color;

  /// Restituisce l'icona di default in base al tipo di shape
  static IconData _getDefaultIcon(ShapeType shapeType) {
    switch (shapeType) {
      case ShapeType.triangle:
        return Icons.details;
      case ShapeType.square:
        return Icons.square;
      case ShapeType.circle:
        return Icons.circle;
      case ShapeType.oval:
        return Icons.circle_sharp;
      case ShapeType.rectangle:
        return Icons.rectangle;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    switch (shapeType) {
      case ShapeType.triangle:
        _drawTriangle(canvas);
      case ShapeType.square:
        _drawSquare(canvas);
      case ShapeType.circle:
        _drawCircle(canvas);
      case ShapeType.oval:
        _drawOval(canvas);
      case ShapeType.rectangle:
        _drawRectangle(canvas);
    }
  }

  /// Disegna un triangolo
  void _drawTriangle(Canvas canvas) {
    _drawIcon(canvas, icon!);
  }

  /// Disegna un quadrato
  void _drawSquare(Canvas canvas) {
    _drawIcon(canvas, icon!);
  }

  /// Disegna un cerchio
  void _drawCircle(Canvas canvas) {
    _drawIcon(canvas, icon!);
  }

  /// Disegna un ovale
  void _drawOval(Canvas canvas) {
    _drawIcon(canvas, icon!);
  }

  /// Disegna un rettangolo
  void _drawRectangle(Canvas canvas) {
    _drawIcon(canvas, icon!);
  }

  /// Disegna un'icona di Flutter
  void _drawIcon(Canvas canvas, IconData iconData) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontFamily: iconData.fontFamily,
          fontSize: shapeSize,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, 0));
  }
}