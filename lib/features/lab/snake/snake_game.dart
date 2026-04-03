library;

import 'dart:math';

/// Grid coordinate for the Snake board.
class GridPoint {
  const GridPoint(this.x, this.y);

  final int x;
  final int y;

  GridPoint translate(Direction direction) {
    return GridPoint(x + direction.dx, y + direction.dy);
  }

  @override
  bool operator ==(Object other) {
    return other is GridPoint && other.x == x && other.y == y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}

/// Possible movement directions.
enum Direction {
  up(0, -1),
  down(0, 1),
  left(-1, 0),
  right(1, 0);

  const Direction(this.dx, this.dy);

  final int dx;
  final int dy;

  bool isOpposite(Direction other) {
    return dx == -other.dx && dy == -other.dy;
  }
}

typedef RandomIndexPicker = int Function(int max);

int _defaultPickIndex(int max) => Random().nextInt(max);

/// Immutable snapshot of the Snake game.
class SnakeGameState {
  const SnakeGameState({
    required this.boardWidth,
    required this.boardHeight,
    required this.snake,
    required this.direction,
    required this.pendingDirection,
    required this.food,
    required this.score,
    required this.isGameOver,
    required this.isPaused,
  });

  factory SnakeGameState.initial({
    int boardWidth = 16,
    int boardHeight = 16,
    RandomIndexPicker pickIndex = _defaultPickIndex,
  }) {
    final center = GridPoint(boardWidth ~/ 2, boardHeight ~/ 2);
    final snake = <GridPoint>[
      center,
      GridPoint(center.x - 1, center.y),
      GridPoint(center.x - 2, center.y),
    ];

    return SnakeGameState(
      boardWidth: boardWidth,
      boardHeight: boardHeight,
      snake: snake,
      direction: Direction.right,
      pendingDirection: Direction.right,
      food: _spawnFood(
        boardWidth: boardWidth,
        boardHeight: boardHeight,
        snake: snake,
        pickIndex: pickIndex,
      ),
      score: 0,
      isGameOver: false,
      isPaused: false,
    );
  }

  final int boardWidth;
  final int boardHeight;
  final List<GridPoint> snake;
  final Direction direction;
  final Direction pendingDirection;
  final GridPoint? food;
  final int score;
  final bool isGameOver;
  final bool isPaused;

  SnakeGameState queueDirection(Direction nextDirection) {
    if (isGameOver) {
      return this;
    }

    final activeDirection = pendingDirection;
    if (snake.length > 1 && activeDirection.isOpposite(nextDirection)) {
      return this;
    }

    return copyWith(pendingDirection: nextDirection);
  }

  SnakeGameState togglePause() {
    if (isGameOver) {
      return this;
    }

    return copyWith(isPaused: !isPaused);
  }

  SnakeGameState step({RandomIndexPicker pickIndex = _defaultPickIndex}) {
    if (isGameOver || isPaused) {
      return this;
    }

    final nextHead = snake.first.translate(pendingDirection);
    final didEat = nextHead == food;
    final collisionBody = didEat ? snake : snake.take(snake.length - 1);
    if (_hitsWall(nextHead) || collisionBody.contains(nextHead)) {
      return copyWith(
        direction: pendingDirection,
        isGameOver: true,
      );
    }

    final nextSnake = <GridPoint>[nextHead, ...snake];
    if (!didEat) {
      nextSnake.removeLast();
    }

    return copyWith(
      snake: nextSnake,
      direction: pendingDirection,
      pendingDirection: pendingDirection,
      food: didEat
          ? _spawnFood(
              boardWidth: boardWidth,
              boardHeight: boardHeight,
              snake: nextSnake,
              pickIndex: pickIndex,
            )
          : food,
      score: didEat ? score + 1 : score,
    );
  }

  SnakeGameState restart({RandomIndexPicker pickIndex = _defaultPickIndex}) {
    return SnakeGameState.initial(
      boardWidth: boardWidth,
      boardHeight: boardHeight,
      pickIndex: pickIndex,
    );
  }

  SnakeGameState copyWith({
    List<GridPoint>? snake,
    Direction? direction,
    Direction? pendingDirection,
    GridPoint? food,
    int? score,
    bool? isGameOver,
    bool? isPaused,
    bool clearFood = false,
  }) {
    return SnakeGameState(
      boardWidth: boardWidth,
      boardHeight: boardHeight,
      snake: snake ?? this.snake,
      direction: direction ?? this.direction,
      pendingDirection: pendingDirection ?? this.pendingDirection,
      food: clearFood ? null : (food ?? this.food),
      score: score ?? this.score,
      isGameOver: isGameOver ?? this.isGameOver,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  bool _hitsWall(GridPoint point) {
    return point.x < 0 ||
        point.y < 0 ||
        point.x >= boardWidth ||
        point.y >= boardHeight;
  }

  static GridPoint? _spawnFood({
    required int boardWidth,
    required int boardHeight,
    required List<GridPoint> snake,
    required RandomIndexPicker pickIndex,
  }) {
    final snakeCells = snake.toSet();
    final emptyCells = <GridPoint>[];

    for (var y = 0; y < boardHeight; y++) {
      for (var x = 0; x < boardWidth; x++) {
        final point = GridPoint(x, y);
        if (!snakeCells.contains(point)) {
          emptyCells.add(point);
        }
      }
    }

    if (emptyCells.isEmpty) {
      return null;
    }

    return emptyCells[pickIndex(emptyCells.length)];
  }
}
