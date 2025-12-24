import 'package:flame_engine_tictactoe/features/flame/constants/player.dart';

class GameState {
  final List<Player> board;
  final Player currentPlayer;
  final Player? winner;
  final List<int>? winningLine;

  GameState({required this.board, required this.currentPlayer, this.winner, this.winningLine});
}