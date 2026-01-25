import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:quick_tap/game/quick_tap_game.dart';
import 'package:quick_tap/game/game_end_state.dart';
import 'package:quick_tap/constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState(); 
}


class _GameScreenState extends State<GameScreen> {
  late final QuickTapGame game;

  @override
  void initState() {
    super.initState();
    game = QuickTapGame(
      endCallback: (GameEndState endState) {
        switch (endState) {
          case GameEndState.wrong:
            // context.goNamed(AppRoute.endWrong.name);
            debugPrint('End State: Wrong');
            break;
          case GameEndState.correct:
            // context.goNamed(AppRoute.endCorrect.name);
            debugPrint('End State: Correct');
            break;
        }
        // context.goNamed(AppRoute.end.name);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: Center(
              child: FittedBox(
                child: SizedBox(
                  width: gameWidth,
                  height: gameHeight,
                  child: GameWidget(
                    game: game,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}