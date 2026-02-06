/// Longinus 002 工具库页面
library;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// 工具库页面
/// 脚手架工具与开发工具集合
class ToolkitPage extends StatelessWidget {
  const ToolkitPage({super.key});

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
                              '工具库',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '6 个工具可用',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondaryLight,
                                  ),
                            ),
                          ],
                        ),
                        // 筛选按钮
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.tune_rounded, size: 18),
                          label: const Text('筛选'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textSecondaryLight,
                          ),
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
                    const SizedBox(height: 16),

                    // 分类标签
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _CategoryChip(label: '全部', isSelected: true),
                          _CategoryChip(label: '脚手架'),
                          _CategoryChip(label: 'CLI工具'),
                          _CategoryChip(label: '代码生成'),
                          _CategoryChip(label: '配置'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 置顶工具区域
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                '置顶工具',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),
          ),

          // 工具卡片列表
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ToolCard(
                  icon: Icons.folder_outlined,
                  title: 'React 项目脚手架',
                  description: '快速创建 React + TypeScript + Vite 项目',
                  tags: ['脚手架', 'React', 'TypeScript'],
                  isPinned: true,
                ),
                const SizedBox(height: 12),
                _ToolCard(
                  icon: Icons.code_rounded,
                  title: '组件代码生成器',
                  description: '根据模板快速生成标准化的组件代码',
                  tags: ['代码生成', 'CLI'],
                  isPinned: true,
                ),
                const SizedBox(height: 20),
                Text(
                  '全部工具',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 12),
                _ToolCard(
                  icon: Icons.api_rounded,
                  title: 'API 接口生成工具',
                  description: '从 OpenAPI 规范自动生成类型安全的 API 客户端代码',
                  tags: ['代码生成', 'API'],
                ),
                const SizedBox(height: 80), // 底部留白
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// 分类标签组件
class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.dividerLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondaryLight,
          ),
        ),
      ),
    );
  }
}

/// 工具卡片组件
class _ToolCard extends StatelessWidget {
  const _ToolCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    this.isPinned = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerLight, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),

          // 内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题行
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (isPinned)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '置顶',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textSecondaryLight,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // 描述
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // 标签
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 11,
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
        ],
      ),
    );
  }
}
