import 'package:go_router/go_router.dart';
import 'package:quick_tap/views/menu_screen.dart';
import 'package:quick_tap/views/game_screen.dart';
import 'package:quick_tap/views/end_screen.dart';
import 'package:quick_tap/game/game_end_state.dart';

enum AppRoute {
  game,
  menu,
  endWin,
  endLose
}

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/menu',
    routes: <RouteBase> [
      GoRoute(
        path: '/menu',
        name: AppRoute.menu.name,
        pageBuilder: (context, state) => const NoTransitionPage<void>(
          child: MenuScreen()
        )
      ),
      GoRoute(
        path: '/game',
        name: AppRoute.game.name,
        builder: (context, state) {
          return const GameScreen();
        },
      ),
      GoRoute(
        path: '/endWin',
        name: AppRoute.endWin.name,
        builder: (context, state) {
          return const EndScreen(gameEndState: GameEndState.win);
        },
      ),
      GoRoute(
        path: '/endLose',
        name: AppRoute.endLose.name,
        builder: (context, state) {
          return const EndScreen(gameEndState: GameEndState.lose);
        },
      )
    ],
  );
}