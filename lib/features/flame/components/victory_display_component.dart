
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_engine_tictactoe/features/flame/games/tic_tac_toe_game.dart';
import 'package:flutter/material.dart';

class VictoryDisplayComponent extends PositionComponent with HasGameReference<TicTacToeGame> {
  final String message;

  VictoryDisplayComponent(this.message, {required Vector2 size}) : super(size: size);

  @override
  Future<void> onLoad() async {
    // Semi-transparent background overlay
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.black.withOpacity(0.6),
    ));

    final text = TextComponent(
      text: message,
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(blurRadius: 10, color: Colors.blue, offset: Offset(2, 2))],
        ),
      ),
    );

    add(text);

    // Pulse animation
    text.add(
      ScaleEffect.to(
        Vector2.all(1.2),
        EffectController(duration: 0.6, reverseDuration: 0.6, infinite: true),
      ),
    );
  }
}