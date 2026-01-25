import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/game_world.dart';
import 'package:quick_tap/constants.dart';
import 'dart:async';
import 'package:quick_tap/game/game_end_state.dart';

class QuickTapGame extends FlameGame<GameWorld> with TapCallbacks, HorizontalDragDetector, KeyboardEvents {
  QuickTapGame({  required this.endCallback }) : 
      super(
        world: GameWorld(),
        camera: CameraComponent.withFixedResolution(
          width: gameWidth, height: gameHeight)
      );
  final void Function(GameEndState endState) endCallback;

 
  @override  
  Color backgroundColor() {
    return Colors.white;
  }

   // Gestisce il tap sullo schermo
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    debugPrint('Screen tapped at: ${event.localPosition}');
  }


  // permette di vedere i bounding box dei componenti in debug mode
  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
  }

 
}