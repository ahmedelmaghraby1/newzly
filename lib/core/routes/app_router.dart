import 'package:go_router/go_router.dart';
import 'package:newzly/core/routes/app_routes.dart';
import 'package:newzly/core/utils/routing_transition.dart';
import 'package:newzly/features/home/presentation/UI/screens/article_screen.dart';
import 'package:newzly/features/home/presentation/UI/screens/home_screen.dart';
import 'package:newzly/features/settings/presentation/UI/screens/settings_screen.dart';

class AppRouter {
  static createRouter() {
    GoRouter goRouter = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.homeScreen,
          builder: (context, state) {
            return HomeScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.settingsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: SettingsScreen(),
              transitionsBuilder: routingTransition,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.articleScreen,
          pageBuilder: (context, state) {
            final String url = state.pathParameters['articleUrl'] as String;
            return CustomTransitionPage(
              child: ArticleScreen(url: url),
              transitionsBuilder: routingTransition,
            );
          },
        ),
      ],
    );
    return goRouter;
  }
}
