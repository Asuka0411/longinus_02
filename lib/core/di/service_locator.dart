/// Longinus 002 依赖注入封装
/// 基于 Riverpod，但提供抽象层便于后续替换
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service Locator 抽象
/// 当前实现基于 Riverpod，可根据需要替换为其他方案
abstract final class ServiceLocator {
  /// 创建 Provider 容器
  static ProviderContainer createContainer() {
    return ProviderContainer();
  }
}

/// 主题模式状态
final themeModeProvider = StateProvider<bool>((ref) => false);
