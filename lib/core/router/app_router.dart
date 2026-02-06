/// Longinus 002 路由配置
library;

import 'package:go_router/go_router.dart';

import '../../features/main_shell.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/toolkit/toolkit_page.dart';
import '../../features/portfolio/portfolio_page.dart';
import '../../features/lab/lab_page.dart';
import '../../features/profile/profile_page.dart';
import 'route_registry.dart';

/// 路由路径常量
abstract final class RoutePaths {
  static const String splash = '/';
  static const String home = '/home';
  static const String toolkit = '/home/toolkit';
  static const String portfolio = '/home/portfolio';
  static const String lab = '/home/lab';
  static const String profile = '/home/profile';
}

/// 应用路由配置
final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.splash,
  routes: [
    // 启动页
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    // 主页面 Shell（带底部导航）
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: 工具库
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.toolkit,
              builder: (context, state) => const ToolkitPage(),
              routes: [
                // 模块注册的子路由将在这里添加
                ...RouteRegistry.instance.allRoutes,
              ],
            ),
          ],
        ),

        // Tab 2: 作品
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.portfolio,
              builder: (context, state) => const PortfolioPage(),
            ),
          ],
        ),

        // Tab 3: 试验场
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.lab,
              builder: (context, state) => const LabPage(),
            ),
          ],
        ),

        // Tab 4: 我的
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RoutePaths.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
