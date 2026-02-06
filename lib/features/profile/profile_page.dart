/// Longinus 002 我的页面
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/di/service_locator.dart';

/// 我的页面
/// 设置与偏好
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 用户信息卡片
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // 头像
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'D',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 用户名
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '开发者',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'developer@example.com',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 统计数据
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _StatCard(value: '12', label: '工具'),
                    const SizedBox(width: 12),
                    _StatCard(value: '6', label: '作品'),
                    const SizedBox(width: 12),
                    _StatCard(value: '8', label: '实验'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 外观设置
              _SectionHeader(title: '外观'),
              _SettingsItem(
                icon: Icons.brightness_6_outlined,
                title: '深色模式',
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).state = value;
                  },
                  activeTrackColor: AppColors.primary,
                ),
              ),

              const SizedBox(height: 16),

              // 关于
              _SectionHeader(title: '关于'),
              _SettingsItem(
                icon: Icons.info_outline_rounded,
                title: '关于应用',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.language_rounded,
                title: '个人网站',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.code_rounded,
                title: 'GitHub',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.mail_outline_rounded,
                title: '联系方式',
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // 版本信息
              Text(
                'Version 1.0.0 · 版本 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

/// 统计卡片
class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.dividerLight, width: 0.5),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 设置区块标题
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ),
    );
  }
}

/// 设置项
class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(color: AppColors.dividerLight, width: 0.5),
          ),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.textPrimaryLight, size: 22),
          title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          trailing:
              trailing ??
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondaryLight,
              ),
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
