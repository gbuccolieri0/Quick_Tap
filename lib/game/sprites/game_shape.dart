import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:quick_tap/constants.dart';
import 'package:flame/events.dart';

enum ShapeType { triangle, square, circle, rectangle }
typedef OnTapDown = void Function(TapDownEvent event);

class GameShape extends PositionComponent with TapCallbacks, HasGameReference<QuickTapGame> {
  final ShapeType shapeType;
  final Color color;
  Vector2 velocity;
  final OnTapDown? onTapDownCallback;
  double rotationSpeed;

  GameShape({
    required Vector2 position,
    required this.velocity,
    required double size,
    required this.shapeType,
    this.color = Colors.blue,
    this.onTapDownCallback,
    this.rotationSpeed = 0, // Default: nessuna rotazione
    double initialAngle = 0, // Angolo iniziale in radianti
  }) : super
    (
      position: position, 
      size: Vector2.all(size),
      angle: initialAngle,
      anchor: Anchor.center, // IMPORTANTE: Ruota attorno al centro
    );

  @override
  void update(double dt) {
    super.update(dt);

    // 1. Applichiamo il movimento: posizione = posizione + (velocità * tempo)
    // Se velocity è Vector2(0,0), la forma rimarrà ferma.
    position += velocity * dt;

    // Applichiamo la rotazione
    angle += rotationSpeed * dt;

    // 2. Logica di rimbalzo (Bounce)
    _checkBounds();
  }

  void _checkBounds() {
    // Bordi orizzontali (Destra e Sinistra)
    if (position.x + size.x >= gameWidth/2 + size.x/2) {
      velocity.x = -velocity.x.abs(); // Forza la direzione a sinistra
      position.x = gameWidth/2 - size.x/2;
    } else if (position.x <= -gameWidth/2 + size.x/2) {
      velocity.x = velocity.x.abs(); // Forza la direzione a destra
      position.x = -gameWidth/2 + size.x/2;
    }

    // Bordi verticali (Sopra e Sotto)
    if (position.y + size.y >= gameHeight/2 + size.y/2) {
      velocity.y = -velocity.y.abs(); // Forza la direzione in su
      position.y = gameHeight/2 - size.y/2;
    } else if (position.y <= -gameHeight/2 + size.y/2) {
      velocity.y = velocity.y.abs(); // Forza la direzione in giù
      position.y = -gameHeight/2 + size.y/2;
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    switch (shapeType) {
      case ShapeType.circle:
        // Calcoliamo se la distanza dal centro è minore del raggio
        final center = size / 2;
        final radius = size.x / 2;
        return point.distanceTo(center) <= radius;

      case ShapeType.triangle:
        // Per il triangolo la logica matematica è più complessa, 
        // ma puoi usare path.contains(point.toOffset())
        return _getTrianglePath().contains(point.toOffset());

      case ShapeType.square:
      case ShapeType.rectangle:
      default:
        // Per i rettangoli, il comportamento standard va bene
        return super.containsLocalPoint(point);
    }
  }

  // Helper per riutilizzare lo stesso path sia in render che in containsLocalPoint
  Path _getTrianglePath() {
    return Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(0, size.y)
      ..lineTo(size.x, size.y)
      ..close();
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("Hai toccato: ${shapeType.name}");
    
    // Comunichiamo al gioco quale forma è stata toccata
    game.world.checkTappedShape(this);
    onTapDownCallback?.call(event);
    
  }

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