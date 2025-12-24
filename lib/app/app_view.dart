import 'package:flame/game.dart';
import 'package:flame_engine_tictactoe/features/flame/games/tic_tac_toe_game.dart';
import 'package:flame_engine_tictactoe/features/flame/logic/tic_tac_toe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TicTacToeCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Container(
              color: Colors.grey[900], // Dark background for contrast
              child: Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16, // Forces a phone-like ratio if desired
                  child: GameWidget(
                    game: TicTacToeGame(context.read<TicTacToeCubit>()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
