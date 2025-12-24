
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class WinningLineComponent extends PositionComponent {
  final List<int> indices;
  final double cellSize;
  double _progress = 0.0; // For animation

  WinningLineComponent({required this.indices, required this.cellSize});

  @override
  void update(double dt) {
    super.update(dt);
    if (_progress < 1.0) {
      _progress += dt * 3; // Speed of line drawing
      if (_progress > 1.0) _progress = 1.0;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.yellowAccent
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Get centers of the start and end indices
    final startPos = _getCenter(indices.first);
    final endPos = _getCenter(indices.last);

    // Calculate current end point based on animation progress
    final currentEnd = startPos + (endPos - startPos) * _progress;

    canvas.drawLine(startPos.toOffset(), currentEnd.toOffset(), paint);
  }

  Vector2 _getCenter(int index) {
    final x = (index % 3) * cellSize + (cellSize / 2);
    final y = (index ~/ 3) * cellSize + (cellSize / 2);
    return Vector2(x, y);
  }
}