/// Longinus 002 作品页面
library;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// 作品页面
/// 已完成的 UI / 设计成果展示
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 页面标题
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题行
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '作品集',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '6 个设计作品',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondaryLight,
                                  ),
                            ),
                          ],
                        ),
                        // 视图切换
                        Row(
                          children: [
                            _ViewToggle(
                              icon: Icons.grid_view_rounded,
                              isSelected: true,
                            ),
                            const SizedBox(width: 4),
                            _ViewToggle(
                              icon: Icons.view_list_rounded,
                              isSelected: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 搜索框
                    TextField(
                      decoration: InputDecoration(
                        hintText: '搜索工具、作品或实验...',
                        hintStyle: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 作品网格
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildListDelegate([
                _PortfolioCard(
                  title: 'E-commerce Dashboard',
                  subtitle: 'UI Design · 用户界面设计',
                  tags: ['Dashboard', '数据可视化'],
                  color: Colors.blueGrey[100]!,
                ),
                _PortfolioCard(
                  title: '移动端健康应用',
                  subtitle: 'App Design · 应用设计',
                  tags: ['Mobile', 'Health'],
                  color: Colors.cyan[100]!,
                ),
                _PortfolioCard(
                  title: '设计系统组件库',
                  subtitle: 'Design System · 设计系统',
                  tags: ['组件库', 'Figma'],
                  color: Colors.grey[200]!,
                ),
                _PortfolioCard(
                  title: '品牌视觉识别系统',
                  subtitle: 'Branding · 品牌形象',
                  tags: ['品牌', 'VI'],
                  color: Colors.pink[100]!,
                ),
              ]),
            ),
          ),

          // 底部留白
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

/// 视图切换按钮
class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.icon, required this.isSelected});

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.textPrimaryLight : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isSelected ? Colors.white : AppColors.textSecondaryLight,
      ),
    );
  }
}

/// 作品卡片组件
class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.color,
  });

  final String title;
  final String subtitle;
  final List<String> tags;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerLight, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面图
          Container(height: 100, width: double.infinity, color: color),

          // 内容
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: tags
                        .map(
                          (tag) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
