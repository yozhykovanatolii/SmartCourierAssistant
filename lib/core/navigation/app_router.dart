import 'package:go_router/go_router.dart';
import 'package:smart_courier_assistant/core/navigation/app_routes.dart';
import 'package:smart_courier_assistant/domain/entity/route_entity.dart';
import 'package:smart_courier_assistant/presentation/page/edit_profile/edit_profile_page.dart';
import 'package:smart_courier_assistant/presentation/page/forgot_password/forgot_password_page.dart';
import 'package:smart_courier_assistant/presentation/page/home/home_page.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';
import 'package:smart_courier_assistant/presentation/page/profile/profile_page.dart';
import 'package:smart_courier_assistant/presentation/page/register/register_page.dart';
import 'package:smart_courier_assistant/presentation/page/route_detail/route_detail_page.dart';
import 'package:smart_courier_assistant/presentation/page/routes_history/routes_history_page.dart';
import 'package:smart_courier_assistant/presentation/page/settings/settings_page.dart';
import 'package:smart_courier_assistant/presentation/page/splash/splash_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._();

  AppRouter._();

  factory AppRouter() => _instance;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splashPage,
    debugLogDiagnostics: true,
    routes: _getRoutes(),
  );

  static List<RouteBase> _getRoutes() {
    return [
      GoRoute(
        path: AppRoutes.splashPage,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.loginPage,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.registerPage,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordPage,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.homePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.profilePage,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.editProfilePage,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.myRoutesPage,
        builder: (context, state) => const RoutesHistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.routeDetailPage,
        builder: (context, state) {
          final route = state.extra as RouteEntity;
          return RouteDetailPage(route: route);
        },
      ),
      GoRoute(
        path: AppRoutes.settingsPage,
        builder: (context, state) => const SettingsPage(),
      ),
    ];
  }
}
