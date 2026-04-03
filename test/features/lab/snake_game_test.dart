import 'package:flutter_test/flutter_test.dart';
import 'package:longinus_02/features/lab/snake/snake_game.dart';

void main() {
  group('SnakeGameState', () {
    test('step 会按当前方向前进', () {
      const snake = [
        GridPoint(2, 2),
        GridPoint(1, 2),
        GridPoint(0, 2),
      ];
      final state = SnakeGameState(
        boardWidth: 8,
        boardHeight: 8,
        snake: snake,
        direction: Direction.right,
        pendingDirection: Direction.right,
        food: const GridPoint(6, 6),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step();

      expect(
        next.snake,
        const [GridPoint(3, 2), GridPoint(2, 2), GridPoint(1, 2)],
      );
      expect(next.score, 0);
      expect(next.isGameOver, isFalse);
    });

    test('吃到食物会增长并加分', () {
      const snake = [
        GridPoint(2, 2),
        GridPoint(1, 2),
        GridPoint(0, 2),
      ];
      final state = SnakeGameState(
        boardWidth: 6,
        boardHeight: 6,
        snake: snake,
        direction: Direction.right,
        pendingDirection: Direction.right,
        food: const GridPoint(3, 2),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step(pickIndex: (_) => 0);

      expect(
        next.snake,
        const [
          GridPoint(3, 2),
          GridPoint(2, 2),
          GridPoint(1, 2),
          GridPoint(0, 2),
        ],
      );
      expect(next.score, 1);
      expect(next.food, const GridPoint(0, 0));
    });

    test('撞墙会进入 game over', () {
      const snake = [
        GridPoint(3, 1),
        GridPoint(2, 1),
        GridPoint(1, 1),
      ];
      final state = SnakeGameState(
        boardWidth: 4,
        boardHeight: 4,
        snake: snake,
        direction: Direction.right,
        pendingDirection: Direction.right,
        food: const GridPoint(0, 0),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step();

      expect(next.isGameOver, isTrue);
    });

    test('撞到自己会进入 game over', () {
      const snake = [
        GridPoint(2, 1),
        GridPoint(2, 2),
        GridPoint(1, 2),
        GridPoint(1, 1),
      ];
      final state = SnakeGameState(
        boardWidth: 5,
        boardHeight: 5,
        snake: snake,
        direction: Direction.down,
        pendingDirection: Direction.down,
        food: const GridPoint(4, 4),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step();

      expect(next.isGameOver, isTrue);
    });

    test('不会把食物生成在蛇身上', () {
      const snake = [
        GridPoint(2, 0),
        GridPoint(1, 0),
        GridPoint(0, 0),
      ];
      final state = SnakeGameState(
        boardWidth: 4,
        boardHeight: 4,
        snake: snake,
        direction: Direction.right,
        pendingDirection: Direction.right,
        food: const GridPoint(3, 0),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step(pickIndex: (_) => 0);

      expect(next.food, isNot(isIn(snake)));
    });

    test('移动到原尾巴位置不算碰撞', () {
      const snake = [
        GridPoint(2, 1),
        GridPoint(2, 2),
        GridPoint(1, 2),
        GridPoint(1, 1),
      ];
      final state = SnakeGameState(
        boardWidth: 5,
        boardHeight: 5,
        snake: snake,
        direction: Direction.up,
        pendingDirection: Direction.left,
        food: const GridPoint(4, 4),
        score: 0,
        isGameOver: false,
        isPaused: false,
      );

      final next = state.step();

      expect(next.isGameOver, isFalse);
      expect(next.snake.first, const GridPoint(1, 1));
    });

    test('长度大于 1 时不能直接反向', () {
      final state = SnakeGameState.initial(
        boardWidth: 8,
        boardHeight: 8,
        pickIndex: (_) => 0,
      );

      final next = state.queueDirection(Direction.left);

      expect(next.pendingDirection, Direction.right);
    });
  });
}
