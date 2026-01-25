// import 'package:flutter_application_1/game_end_state.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_tap/views/menu_screen.dart';
import 'package:quick_tap/views/game_screen.dart';
// import 'package:flutter_application_1/views/end_screen.dart';

enum AppRoute {
  game,
  menu,
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
      )
    ],
  );
}