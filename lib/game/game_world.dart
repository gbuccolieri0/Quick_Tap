import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:flame/components.dart';
// import 'package:flutter_application_1/game/level_data.dart';
import 'dart:async';
import 'package:quick_tap/game/sprites/shape.dart';
import 'package:flutter/material.dart'; 
import 'package:quick_tap/constants.dart';

class GameWorld extends World with HasGameReference<QuickTapGame> {

  // GPPBCC
  //  Devo disegnare le shape senza che ci siano degli errori
  // Shape triangle = Shape(
  //   shapeType: ShapeType.triangle,
  //   shapeSize: 90,
  //   color: Colors.red,
  // );

  
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    // add(Player(position: Vector2(gameWidth/4, 0.0), radius: gameHeight/8));
    // add(triangle);
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