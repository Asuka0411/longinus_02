/// Longinus 002 试验场页面
library;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'snake/snake_game_widget.dart';

/// 试验场页面
/// 展示进行中的实验和可运行 Demo
class LabPage extends StatelessWidget {
  const LabPage({super.key});

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
                    Text(
                      '试验场',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '技术实验与可运行 Demo',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 实验列表
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SnakeGameWidget(),
                const SizedBox(height: 12),
                _ExperimentCard(
                  title: 'HTTP 客户端对比',
                  description: '对比 dio、http、chopper 等 HTTP 客户端库的性能与易用性',
                  techPoints: ['dio', 'http', 'chopper'],
                  status: ExperimentStatus.inProgress,
                ),
                const SizedBox(height: 12),
                _ExperimentCard(
                  title: '状态管理方案测试',
                  description: '实验 Riverpod、Bloc、GetX 在不同场景下的表现',
                  techPoints: ['Riverpod', 'Bloc', 'GetX'],
                  status: ExperimentStatus.inProgress,
                ),
                const SizedBox(height: 12),
                _ExperimentCard(
                  title: '动画性能优化',
                  description: '使用 CustomPaint 实现高性能动画效果',
                  techPoints: ['CustomPaint', 'Animation'],
                  status: ExperimentStatus.completed,
                ),
                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/// 实验状态
enum ExperimentStatus { inProgress, completed }

/// 实验卡片组件
class _ExperimentCard extends StatelessWidget {
  const _ExperimentCard({
    required this.title,
    required this.description,
    required this.techPoints,
    required this.status,
  });

  final String title;
  final String description;
  final List<String> techPoints;
  final ExperimentStatus status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == ExperimentStatus.completed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.dividerLight, width: 0.5),
      ),
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
              // 状态标签
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isCompleted ? '已完成' : '进行中',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isCompleted ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 描述
          Text(description, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),

          // 技术点标签
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: techPoints
                .map(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),

          // 操作按钮
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text('运行 Demo'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz_rounded),
                color: AppColors.textSecondaryLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
