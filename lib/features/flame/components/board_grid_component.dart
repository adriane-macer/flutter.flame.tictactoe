import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class BoardGridComponent extends PositionComponent {
  BoardGridComponent({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    double cellSize = size.x / 3;

    // Vertical Lines
    canvas.drawLine(Offset(cellSize, 10), Offset(cellSize, size.y - 10), paint);
    canvas.drawLine(Offset(cellSize * 2, 10), Offset(cellSize * 2, size.y - 10), paint);

    // Horizontal Lines
    canvas.drawLine(Offset(10, cellSize), Offset(size.x - 10, cellSize), paint);
    canvas.drawLine(Offset(10, cellSize * 2), Offset(size.x - 10, cellSize * 2), paint);
  }
}