import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter for rendering an animated progress arc with customizable properties.
class BasicArcProgressPainter extends CustomPainter {
  /// Creates a [BasicArcProgressPainter] with the specified properties.
  ///
  /// The [currentValue] represents the current progress value.
  /// The [destinatonValue] is the target value for the progress arc.
  /// The [totalValue] represents the maximum possible progress.
  /// The [arcHeight] is the height of the progress arc.
  /// The [arcWidth] is the width of the progress arc.
  /// The [backgroundArcStrokeThickness] is the thickness of the background arc.
  /// The [progressArcStrokeThickness] is the thickness of the progress arc.
  /// The [arcBackgroundColor] is the background color of the progress arc.
  /// The [arcProgressGradientColors] is a list of colors for a gradient effect.
  /// The [enableStepperEffect] enables a stepwise animation effect.
  /// The [isPrgressCurveFilled] determines whether to fill the progress arc.
  /// The [isRoundEdges] specifies whether to round the edges of the arc.
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

  /// The current value of the progress arc.
  final double currentValue;

  /// The destination value for the progress arc to reach.
  final double destinatonValue;

  /// The total value representing the maximum possible progress.
  final double totalValue;

  /// The height of the progress arc.
  final double arcHeight;

  /// The width of the progress arc.
  final double arcWidth;

  /// The thickness of the background arc.
  final double backgroundArcStrokeThickness;

  /// The thickness of the progress arc.
  final double progressArcStrokeThickness;

  /// The background color of the progress arc.
  final Color arcBackgroundColor;

  /// List of colors for a gradient effect on the progress arc.
  final List<Color> arcProgressGradientColors;

  /// Whether to enable a stepwise animation effect when the score changes.
  final bool enableStepperEffect;

  /// Whether to fill the progress arc with color.
  final bool isPrgressCurveFilled;

  /// Whether to round the edges of the progress arc.
  final bool isRoundEdges;

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
