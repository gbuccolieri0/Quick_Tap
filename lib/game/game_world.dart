import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:flame/components.dart';
import 'dart:async';
import 'package:flutter/material.dart'; 
import 'package:quick_tap/constants.dart';
import 'package:quick_tap/game/sprites/game_shape.dart';
import 'package:quick_tap/game/sprites/tappable_sprite.dart';

class GameWorld extends World with HasGameReference<QuickTapGame> {

  final shape = GameShape(
    position: Vector2(-100, -500), 
    // quando scrivi la posizione ricorda di considerare la dimensione del componente
    size: 200,
    color: Colors.purple,
    shapeType: ShapeType.rectangle,
  );

  final tappableSprite = TappableSprite(
    shapeType: ShapeType.circle,
    shapeSize: 100,
    color: Colors.red,
    position: Vector2(100, 0),
  );
  
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(shape);
    add(tappableSprite);
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