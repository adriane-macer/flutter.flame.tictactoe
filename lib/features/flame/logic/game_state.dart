import 'package:flame_engine_tictactoe/features/flame/constants/player.dart';

class GameState {
  final List<Player> board;
  final Player currentPlayer;
  final Player? winner;

  GameState({required this.board, required this.currentPlayer, this.winner});
}