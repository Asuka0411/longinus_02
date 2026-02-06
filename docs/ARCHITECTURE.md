# 项目架构 (Architecture)

本文档说明 `Longinus 002` 项目的技术架构与核心设计决策。

## 技术栈

| 类别     | 选型           |
| -------- | -------------- |
| 框架     | Flutter 3.x    |
| 状态管理 | Riverpod       |
| 路由     | go_router      |
| 构建     | GitHub Actions |

## 目录结构

```text
lib/
├── main.dart                 # 应用入口
├── app.dart                  # 根组件
├── core/                     # 核心层（稳定，不常变）
│   ├── constants/            # 常量定义
│   │   └── app_colors.dart   # 颜色常量
│   ├── di/                   # 依赖注入
│   │   └── service_locator.dart
│   ├── router/               # 路由
│   │   ├── app_router.dart   # 路由配置
│   │   └── route_registry.dart # 模块路由注册
│   └── theme/                # 主题
│       └── app_theme.dart    # Light/Dark 主题
├── features/                 # 功能模块
│   ├── splash/               # 启动页
│   ├── toolkit/              # 工具库 Tab
│   ├── portfolio/            # 作品 Tab
│   ├── lab/                  # 试验场 Tab
│   └── profile/              # 我的 Tab
├── ui_kit/                   # 通用 UI 组件
│   ├── atoms/                # 原子组件
│   ├── molecules/            # 分子组件
│   └── organisms/            # 有机体组件
└── modules/                  # 可插拔实验模块（预留）
```

## 核心设计

### 1. 模块化路由 (RouteRegistry)

每个功能模块可以通过实现 `RouteModule` 接口自注册路由：

```dart
abstract class RouteModule {
  String get moduleName;
  List<RouteBase> get routes;
}
```

### 2. 依赖注入抽象 (ServiceLocator)

当前基于 Riverpod 实现，封装为抽象接口便于后续替换：

```dart
abstract final class ServiceLocator {
  static ProviderContainer createContainer() => ProviderContainer();
}
```

### 3. 主题系统

- **主色调**：明日香红 (`#E53935`)
- **支持**：Light / Dark 模式切换
- **设计**：iOS 风格，偏工具型 App

## 页面导航

```text
启动页 (Splash)
    │
    └── 主框架 (MainShell) ─── 底部 Tab Bar
             │
             ├── 工具库 (Toolkit)      首页
             ├── 作品集 (Portfolio)
             ├── 试验场 (Lab)
             └── 我的   (Profile)
```
