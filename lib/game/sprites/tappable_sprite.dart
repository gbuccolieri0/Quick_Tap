import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'game_shape.dart'; // Assicurati che il percorso sia corretto

typedef OnTapDown = void Function(TapDownEvent event);

class TappableSprite extends PositionComponent with TapCallbacks {
  final ShapeType shapeType;
  final double shapeSize;
  final Color color;
  final OnTapDown? onTapDownCallback;

  TappableSprite({
    required this.shapeType,
    required this.shapeSize,
    required this.color,
    this.onTapDownCallback,
    super.position, // Passiamo la posizione al costruttore padre
  }) : super(size: Vector2.all(shapeSize)); // Fondamentale: imposta la grandezza per il tap

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Creiamo la visualizzazione della shape
    // Usiamo Vector2.zero() perché la posizione è relativa al padre (TappableSprite)
    final shapeVisual = GameShape(
      position: Vector2.zero(),
      size: shapeSize,
      shapeType: shapeType,
      color: color,
    );

    add(shapeVisual);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // 1. Logica interna: stampa il tipo di shape trovata
    print("Hai toccato la shape: ${shapeType.name}");

    // 2. Esegue il callback esterno se presente
    super.onTapDown(event);
    onTapDownCallback?.call(event);
  }
}