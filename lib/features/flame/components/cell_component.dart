import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_engine_tictactoe/features/flame/constants/player.dart';
import 'package:flame_engine_tictactoe/features/flame/logic/tic_tac_toe_cubit.dart';
import 'package:flutter/material.dart';

class CellComponent extends RectangleComponent with TapCallbacks {
  final int index;
  final TicTacToeCubit cubit;
  Player _currentSymbol = Player.none;
  TextComponent? label;

  CellComponent(this.index, this.cubit, {required Vector2 position, required Vector2 size})
      : super(position: position, size: size){
    paint = Paint()..color = Colors.transparent;
  }

  @override
  void onTapDown(TapDownEvent event) {
    cubit.makeMove(index);
  }

  void updateSymbol(Player newPlayer) {
    if (_currentSymbol == newPlayer) return; // No change
    _currentSymbol = newPlayer;

    // Handle Reset: Remove label if board is cleared
    if (newPlayer == Player.none) {
      label?.removeFromParent();
      label = null;
      return;
    }

    // Add Symbol with Animation
    final symbol = newPlayer == Player.X ? 'X' : 'O';
    label = TextComponent(
      text: symbol,
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(style: TextStyle(fontSize: 48, color: Colors.blue)),
    );

    // Initial state for animation
    label!.scale = Vector2.all(0);
    add(label!);

    // Pop-in animation
    label!.add(
        ScaleEffect.to(
          Vector2.all(1.2), // Slightly overshoot for a "bounce"
          EffectController(duration: 0.2, curve: Curves.easeOut),
        )..onComplete = () {
          label!.add(ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.1)));
        }
    );
    label = TextComponent(
      text: symbol,
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: size.x * 0.6, // Font is 60% of cell width
          color: Colors.blue,
        ),
      ),
    );
    add(label!);
  }
}