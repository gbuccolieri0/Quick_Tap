
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'shape.dart';

typedef OnTapDown = void Function(TapDownEvent event);

class TappableSprite extends PositionComponent with TapCallbacks {
  late final Shape shape;
  final ShapeType shapeType;
  final double shapeSize;
  final Color color;
  final OnTapDown? onTapDownCallback;

  TappableSprite({
    required this.shapeType,
    required this.shapeSize,
    required this.color,
    this.onTapDownCallback,
  });

  @override
  void onLoad() {
    super.onLoad();
    
    // Crea la shape
    shape = Shape(
      shapeType: shapeType,
      shapeSize: shapeSize,
      color: color,
    );
    add(shape);
  }

  // Gestisce il tap sullo sprite
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTapDownCallback?.call(event);
  }

}
