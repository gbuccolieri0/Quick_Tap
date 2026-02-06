import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:flame/components.dart';
import 'dart:async';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:quick_tap/game/level.dart';
import 'package:quick_tap/game/level_data.dart';
import 'package:quick_tap/game/game_end_state.dart';

class GameWorld extends World with HasGameReference<QuickTapGame> {
  late Level currentLevel;
  
  void loadLevel(Level level) {
    currentLevel = level;
    
    // 1. Rimuovi i componenti del livello precedente (se presenti)
    children.whereType<GameShape>().forEach((shape) => shape.removeFromParent());

    // 2. Aggiungi le nuove forme
    for (var config in level.shapes) {
      add(GameShape(
        shapeType: config.type,
        color: config.color,
        position: config.position,
        velocity: config.velocity,
        rotationSpeed: config.rotationSpeed,
        size: config.size,
      ));
    }

    print("Livello ${level.number} caricato: ${level.instruction}");
  }
  
  void checkTappedShape(GameShape shape) {
    print("Checking winning shape ${currentLevel.isWinCondition(shape)}");
    if (currentLevel.isWinCondition(shape)) {
      print("Bravo! Continua così.");
      game.endCallback(GameEndState.win);
    } else {
      print("HAI PERSO: ${currentLevel.instruction}");
      game.endCallback(GameEndState.lose);
    }
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    // add(shape);
    loadLevel(LevelData().getLevel(2));
   }

}
