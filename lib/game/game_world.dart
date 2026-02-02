import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:flame/components.dart';
import 'dart:async';
import 'package:flutter/material.dart'; 
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:quick_tap/game/level.dart';
import 'package:quick_tap/game/level_data.dart';

class GameWorld extends World with HasGameReference<QuickTapGame> {
  late Level currentLevel;
  // final shape = GameShape(
  //   position: Vector2(-100, -500), 
  //   // quando scrivi la posizione ricorda di considerare la dimensione del componente
  //   velocity: Vector2(150, 160),
  //   size: 200,
  //   color: Colors.purple,
  //   shapeType: ShapeType.rectangle,
  // );

  // final shape2 = GameShape(
  //   position: Vector2(-100, -500), 
  //   // quando scrivi la posizione ricorda di considerare la dimensione del componente
  //   velocity: Vector2(180, 260),
  //   size: 200,
  //   color: Colors.black,
  //   shapeType: ShapeType.circle,
  // );

  // final shape3 = GameShape(
  //   position: Vector2(-100, -500), 
  //   // quando scrivi la posizione ricorda di considerare la dimensione del componente
  //   velocity: Vector2.zero(),
  //   size: 200,
  //   color: Colors.orange,
  //   shapeType: ShapeType.triangle,
  // );

  
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
        size: 100,
      ));
    }

    print("Livello ${level.number} caricato: ${level.instruction}");
  }
  
  void checkTappedShape(GameShape shape) {
    print("Checking winning shape ${currentLevel.isWinCondition(shape)}");
    if (currentLevel.isWinCondition(shape)) {
      print("Bravo! Continua così.");
    } else {
      print("HAI PERSO: ${currentLevel.instruction}");
      // Qui puoi gestire il game over
    }
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    // add(shape);
    // add(shape2);
    // add(shape3);
    loadLevel(LevelData().getLevel(1));
   }

}

// class GoGreenWorld extends World with HasGameReference<GoGreenGame> {
//   late final Player player;

//   void loadLevel(List<ObstacleData> levelData) {
//     removeAll(children.whereType<Obstacle>().toList());

//     for (var data in levelData) {
//       Obstacle obstacle;
//       if(data.type == ObstacleType.trash) {
//         obstacle = ObstacleTrash()..position = data.position;
//       } else if(data.type == ObstacleType.fire) {
//         obstacle = ObstacleFire()..position = data.position;
//       } else if(data.type == ObstacleType.water) {
//         obstacle = ObstacleWater()..position = data.position;
//       }
//       else{
//         continue; // skip unknown types
//       }
//       add(obstacle);
//     }
//   }

//   @override
//   FutureOr<void> onLoad() {
//     super.onLoad();
//     player = Player();
//     // Is important to add the player to the world before the bin
//     // so that the player is rendered below the bin
//     add(player);
//     add(Bin());

//     // add(ObstacleTrash()..position = Vector2(0,0));
//     // add(ObstacleFire()..position = Vector2(-obstacleSize*2, 0));
//     // add(ObstacleWater()..position = Vector2(obstacleSize*2, 0));

//     // loadLevel(LevelData().level1());
//     loadLevel(LevelData().getLevel(5));
//   }


//   @override
//   void update(double dt) {
//     super.update(dt);
//     children.whereType<Obstacle>().forEach((element){
//       element.position.y -= (dt * 500);
//       // se vanno verso il basso
//       // if(element.position.y > game.size.y/2 + obstacleSize){
//       //   element.position.y = -(game.size.y/2) - obstacleSize;
//       // }

//       // se vanno verso l'alto
//       if(element.position.y < -(game.size.y/2) - obstacleSize){
//         element.position.y = extendedHeight; // cosi impiegano piu tempo a riapparire
//       }
//     });
//   }
// }