/// Longinus 002 路由注册表
/// 支持模块化路由注册
library;

import 'package:go_router/go_router.dart';

/// 路由模块接口
/// 每个功能模块实现此接口以注册自己的路由
abstract class RouteModule {
  /// 模块名称
  String get moduleName;

  /// 模块路由列表
  List<RouteBase> get routes;
}

/// 路由注册表
/// 收集所有模块的路由
class RouteRegistry {
  RouteRegistry._();

  static final RouteRegistry instance = RouteRegistry._();

  final List<RouteModule> _modules = [];

  /// 注册模块
  void register(RouteModule module) {
    _modules.add(module);
  }

  /// 获取所有已注册模块
  List<RouteModule> get modules => List.unmodifiable(_modules);

  /// 获取所有模块路由
  List<RouteBase> get allRoutes {
    return _modules.expand((m) => m.routes).toList();
  }
}
