import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BasicArcProgressPainter extends CustomPainter {
  final double currentValue;
  final double destinatonValue;
  final double totalValue;
  final double arcHeight;
  final double arcWidth;
  final double backgroundArcStrokeThickness;
  final double progressArcStrokeThickness;

  final Color arcBackgroundColor;
  final List<Color> arcProgressGradientColors;
  final bool enableStepperEffect;
  final bool isPrgressCurveFilled;
  final bool isRoundEdges;

  BasicArcProgressPainter({
    required this.currentValue,
    required this.destinatonValue,
    required this.totalValue,
    required this.arcHeight,
    required this.arcWidth,
    required this.backgroundArcStrokeThickness,
    required this.progressArcStrokeThickness,
    required this.arcBackgroundColor,
    required this.arcProgressGradientColors,
    this.enableStepperEffect = false,
    this.isPrgressCurveFilled = false,
    this.isRoundEdges = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center =
        Offset(size.width / 2, size.height - backgroundArcStrokeThickness);

    canvas.drawArc(
      Rect.fromCenter(
        center: center / 2,
        width: arcWidth,
        height: arcHeight,
      ),
      pi,
      pi,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = arcBackgroundColor
        ..strokeCap = isRoundEdges ? StrokeCap.round : StrokeCap.square
        ..strokeWidth = backgroundArcStrokeThickness,
    );
    canvas.saveLayer(
      Rect.fromCenter(
        center: center,
        width: arcWidth + backgroundArcStrokeThickness,
        height: arcHeight + backgroundArcStrokeThickness,
      ),
      Paint(),
    );

    final Gradient gradient = SweepGradient(
      startAngle: 1.25 * math.pi / 2,
      endAngle: 5.5 * math.pi / (enableStepperEffect ? 8 : 2),
      tileMode: TileMode.repeated,
      colors: arcProgressGradientColors,
    );

    final newCenter =
        Offset(size.width / 2, size.height - backgroundArcStrokeThickness / 2);
    canvas.drawArc(
      Rect.fromCenter(center: newCenter, width: arcWidth, height: arcHeight),
      pi,
      // pi * currentValue * (destinatonValue / totalValue) / destinatonValue,
      (pi * currentValue) / totalValue,
      false,
      Paint()
        ..style =
            isPrgressCurveFilled ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeCap = isRoundEdges ? StrokeCap.round : StrokeCap.square
        ..shader = gradient
            .createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
        ..strokeWidth = progressArcStrokeThickness,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
