

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ResetButton extends PositionComponent with TapCallbacks {
  final VoidCallback onTap;

  ResetButton({required Vector2 position, required this.onTap})
      : super(position: position, size: Vector2(120, 50));

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.redAccent;
    canvas.drawRRect(RRect.fromRectAndRadius(size.toRect(), Radius.circular(8)), paint);
  }

  @override
  Future<void> onLoad() async {
    add(TextComponent(
      text: 'RESET',
      anchor: Anchor.center,
      position: size / 2,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20, color: Colors.white)),
    ));
  }

  @override
  void onTapDown(TapDownEvent event) => onTap();
}