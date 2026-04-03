library;

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import 'snake_game.dart';

/// 最小可玩的贪吃蛇组件。
class SnakeGameWidget extends StatefulWidget {
  const SnakeGameWidget({super.key});

  @override
  State<SnakeGameWidget> createState() => _SnakeGameWidgetState();
}

class _SnakeGameWidgetState extends State<SnakeGameWidget> {
  static const _boardSize = 16;
  static const _tick = Duration(milliseconds: 180);

  late SnakeGameState _state;
  late final FocusNode _focusNode;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _state = SnakeGameState.initial(
      boardWidth: _boardSize,
      boardHeight: _boardSize,
    );
    _focusNode = FocusNode(debugLabel: 'snake-game');
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _state = _state.step();
      });
    });
  }

  void _setDirection(Direction direction) {
    setState(() {
      _state = _state.queueDirection(direction);
    });
    _focusNode.requestFocus();
  }

  void _togglePause() {
    setState(() {
      _state = _state.togglePause();
    });
    _focusNode.requestFocus();
  }

  void _restart() {
    setState(() {
      _state = _state.restart();
    });
    _focusNode.requestFocus();
  }

  KeyEventResult _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
      _setDirection(Direction.up);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.keyS) {
      _setDirection(Direction.down);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.keyA) {
      _setDirection(Direction.left);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.keyD) {
      _setDirection(Direction.right);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.space) {
      _togglePause();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.keyR) {
      _restart();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final snakeCells = _state.snake.toSet();
    final head = _state.snake.first;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Focus(
          autofocus: true,
          focusNode: _focusNode,
          onKeyEvent: (_, event) => _handleKeyEvent(event),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('经典贪吃蛇', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 4),
                        Text(
                          '方向键 / WASD 控制，空格暂停，R 重开',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _StatChip(label: '分数', value: '${_state.score}'),
                ],
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final boardExtent = math.min(
                    constraints.maxWidth,
                    360.0,
                  );

                  return Center(
                    child: Container(
                      width: boardExtent,
                      height: boardExtent,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.dividerLight,
                        ),
                      ),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _boardSize * _boardSize,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _boardSize,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          final point = GridPoint(
                            index % _boardSize,
                            index ~/ _boardSize,
                          );

                          Color fill = AppColors.backgroundLight;
                          if (_state.food == point) {
                            fill = AppColors.success;
                          } else if (point == head) {
                            fill = AppColors.primaryDark;
                          } else if (snakeCells.contains(point)) {
                            fill = AppColors.primary;
                          }

                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: fill,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: _state.isGameOver ? _restart : _togglePause,
                    icon: Icon(
                      _state.isGameOver
                          ? Icons.replay_rounded
                          : _state.isPaused
                          ? Icons.play_arrow_rounded
                          : Icons.pause_rounded,
                    ),
                    label: Text(
                      _state.isGameOver
                          ? '重新开始'
                          : _state.isPaused
                          ? '继续'
                          : '暂停',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _restart,
                    icon: const Icon(Icons.restart_alt_rounded),
                    label: const Text('重开'),
                  ),
                  Text(
                    _state.isGameOver
                        ? '游戏结束，按重开再来一局'
                        : _state.isPaused
                        ? '已暂停'
                        : '碰到边界或自己会结束',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: _DirectionPad(
                  onDirectionSelected: _setDirection,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 2),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _DirectionPad extends StatelessWidget {
  const _DirectionPad({required this.onDirectionSelected});

  final ValueChanged<Direction> onDirectionSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PadButton(
            icon: Icons.keyboard_arrow_up_rounded,
            onPressed: () => onDirectionSelected(Direction.up),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PadButton(
                icon: Icons.keyboard_arrow_left_rounded,
                onPressed: () => onDirectionSelected(Direction.left),
              ),
              const SizedBox(width: 48),
              _PadButton(
                icon: Icons.keyboard_arrow_right_rounded,
                onPressed: () => onDirectionSelected(Direction.right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _PadButton(
            icon: Icons.keyboard_arrow_down_rounded,
            onPressed: () => onDirectionSelected(Direction.down),
          ),
        ],
      ),
    );
  }
}

class _PadButton extends StatelessWidget {
  const _PadButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Icon(icon),
      ),
    );
  }
}
