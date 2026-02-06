/// Longinus 002 颜色常量
/// 明日香风格红色主题
library;

import 'package:flutter/material.dart';

/// 应用核心颜色定义
abstract final class AppColors {
  // ============================================
  // 主色调 - 明日香红
  // ============================================

  /// 主色调红色 - 用于强调、选中态、关键操作
  static const Color primary = Color(0xFFE53935);

  /// 主色调浅色 - 用于背景、hover 状态
  static const Color primaryLight = Color(0xFFFFEBEE);

  /// 主色调深色 - 用于按下状态
  static const Color primaryDark = Color(0xFFC62828);

  // ============================================
  // 中性色 - Light Mode
  // ============================================

  /// 背景色
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// 表面色（卡片、弹窗）
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// 主要文字
  static const Color textPrimaryLight = Color(0xFF1A1A1A);

  /// 次要文字
  static const Color textSecondaryLight = Color(0xFF757575);

  /// 禁用文字
  static const Color textDisabledLight = Color(0xFFBDBDBD);

  /// 分割线
  static const Color dividerLight = Color(0xFFE0E0E0);

  // ============================================
  // 中性色 - Dark Mode
  // ============================================

  /// 背景色
  static const Color backgroundDark = Color(0xFF121212);

  /// 表面色（卡片、弹窗）
  static const Color surfaceDark = Color(0xFF1E1E1E);

  /// 主要文字
  static const Color textPrimaryDark = Color(0xFFFAFAFA);

  /// 次要文字
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  /// 禁用文字
  static const Color textDisabledDark = Color(0xFF616161);

  /// 分割线
  static const Color dividerDark = Color(0xFF2C2C2C);

  // ============================================
  // 语义色
  // ============================================

  /// 成功
  static const Color success = Color(0xFF4CAF50);

  /// 警告
  static const Color warning = Color(0xFFFFC107);

  /// 错误
  static const Color error = Color(0xFFE53935);

  /// 信息
  static const Color info = Color(0xFF2196F3);
}
