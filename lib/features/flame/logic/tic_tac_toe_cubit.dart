

import 'package:bloc/bloc.dart';
import 'package:flame_engine_tictactoe/features/flame/logic/game_state.dart';

import '../constants/player.dart';



class TicTacToeCubit extends Cubit<GameState> {
  TicTacToeCubit() : super(GameState(
    board: List.filled(9, Player.none),
    currentPlayer: Player.X,
  ));

  void makeMove(int index) {
    if (state.board[index] != Player.none || state.winner != null) return;

    final newBoard = List<Player>.from(state.board);
    newBoard[index] = state.currentPlayer;

    final winner = _checkWinner(newBoard);

    emit(GameState(
      board: newBoard,
      currentPlayer: state.currentPlayer == Player.X ? Player.O : Player.X,
      winner: winner,
    ));
  }

  Player? _checkWinner(List<Player> b) {
    const lines = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]];
    for (var l in lines) {
      if (b[l[0]] != Player.none && b[l[0]] == b[l[1]] && b[l[0]] == b[l[2]]) {
        return b[l[0]];
      }
    }
    return null;
  }

  void resetGame() {
    emit(GameState(
      board: List.filled(9, Player.none),
      currentPlayer: Player.X,
      winner: null,
    ));
  }
}