import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_engine_tictactoe/features/flame/components/board_grid_component.dart';
import 'package:flame_engine_tictactoe/features/flame/components/cell_component.dart';
import 'package:flame_engine_tictactoe/features/flame/components/reset_buttons.dart';
import 'package:flame_engine_tictactoe/features/flame/components/victory_display_component.dart';
import 'package:flame_engine_tictactoe/features/flame/components/winning_line_component.dart';
import 'package:flame_engine_tictactoe/features/flame/constants/player.dart';
import 'package:flame_engine_tictactoe/features/flame/logic/tic_tac_toe_cubit.dart';

class TicTacToeGame extends FlameGame {
  final TicTacToeCubit cubit;
  late List<CellComponent> cells;
  VictoryDisplayComponent? _victoryOverlay;

  late double boardSize;
  late PositionComponent boardContainer;

  TicTacToeGame(this.cubit);

  @override
  Future<void> onLoad() async {
    _setupLayout();
    WinningLineComponent? winLine;
    // Re-sync with Cubit
    cubit.stream.listen((state) {
      for (int i = 0; i < 9; i++) {
        cells[i].updateSymbol(state.board[i]);
      }

      // Handle Victory Overlay
      if (state.winner != null) {
        String msg = state.winner == Player.none
            ? "IT'S A DRAW!"
            : "${state.winner!.name} WINS!";
        _victoryOverlay = VictoryDisplayComponent(msg, size: size);
        add(_victoryOverlay!);

        if (state.winningLine != null && winLine == null) {
          winLine = WinningLineComponent(
            indices: state.winningLine!,
            cellSize: boardSize / 3,
          );
          boardContainer.add(winLine!);
        }
      } else {
        // Remove overlay on reset
        winLine?.removeFromParent();
        winLine = null;
        _victoryOverlay?.removeFromParent();
        _victoryOverlay = null;
      }
    });
  }

  // Handle screen rotations or window resizing
  @override
  void onParentResize(Vector2 maxSize) {
    super.onGameResize(maxSize);
    _setupLayout();
  }

  void _setupLayout() {
    // Calculate responsive dimensions
    // Use 80% of the shortest side to ensure it fits portrait or landscape
    boardSize = size.x < size.y ? size.x * 0.8 : size.y * 0.8;
    double cellSize = boardSize / 3;

    final center = size / 2;

    // Clear existing components if re-calculating
    removeAll(children.whereType<PositionComponent>());

    // Create the responsive container
    boardContainer = PositionComponent(
      position: center - Vector2.all(boardSize / 2),
      size: Vector2.all(boardSize),
    );
    add(boardContainer);

    // Add the Grid
    boardContainer.add(
      BoardGridComponent(
        position: Vector2.zero(),
        size: Vector2.all(boardSize),
      ),
    );

    // Add Cells with dynamic size
    cells = List.generate(9, (i) {
      final cell = CellComponent(
        i,
        cubit,
        position: Vector2((i % 3) * cellSize, (i ~/ 3) * cellSize),
        size: Vector2.all(cellSize),
      );
      boardContainer.add(cell);
      return cell;
    });

    // Responsive Reset Button
    add(
      ResetButton(
        position: Vector2(
          center.x - 60,
          boardContainer.position.y + boardSize + 40,
        ),
        onTap: () => cubit.resetGame(),
      ),
    );
  }
}
