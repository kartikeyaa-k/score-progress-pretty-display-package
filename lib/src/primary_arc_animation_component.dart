import 'dart:math';

import 'package:flutter/material.dart';
import 'package:score_progress_pretty_display/src/arc_progress_painter_types/basic_arc_progress_painter.dart';

/// [PrimaryArcAnimationComponent] A widget that displays an animated progress arc with a score text.
///
/// This widget is used to visually represent a score or progress with an animated
/// arc and an optional score text.
class PrimaryArcAnimationComponent extends StatefulWidget {
  /// Creates a [PrimaryArcAnimationComponent].
  ///
  /// The [score] is the final value for the progress arc to stop.
  /// The [maxScore] is the maximum possible score or value.
  /// The [arcHeight] is the height of the progress arc.
  /// The [arcWidth] is the width of the progress arc.
  /// The [backgroundArcStrokeThickness] is the thickness of the background arc.
  /// The [progressArcStrokeThickness] is the thickness of the progress arc.
  ///
  /// Additional parameters allow customization of appearance and behavior:
  /// - [minScoreTextFontSize] : The minimum font size for the score text.
  /// - [maxScoreTextFontSize] : The maximum font size for the score text.
  /// - [arcBackgroundColor] : The background color of the progress arc.
  /// - [arcProgressGradientColors] : List of colors for a gradient effect on the progress arc.
  /// - [enableStepperEffect] : Whether to enable a stepwise animation effect when the score changes.
  /// - [isRoundEdges] : Whether to round the edges of the progress arc.
  /// - [isPrgressCurveFilled] : Whether to fill the progress arc with color.
  /// - [showOutOfScoreFormat] : Whether to show the "/maxScore" format after the score when animation completes.
  /// - [isRoundOffScore] : Whether to round off the score value.
  /// - [isRoundOffScoreWhileProgress] : Whether to round off the score value while the progress is ongoing.
  /// - [scoreAnimationDuration] : The duration of the score animation.
  /// - [scoreTextAnimationDuration] : The duration of the score text animation.
  /// - [scoreTextStyle] : The text style for the score text.
  const PrimaryArcAnimationComponent({
    Key? key,
    required this.score,
    required this.maxScore,
    required this.arcHeight,
    required this.arcWidth,
    required this.backgroundArcStrokeThickness,
    required this.progressArcStrokeThickness,
    this.minScoreTextFontSize = 20,
    this.maxScoreTextFontSize = 35,
    required this.arcBackgroundColor,
    required this.arcProgressGradientColors,
    this.enableStepperEffect = false,
    this.isRoundEdges = false,
    this.isPrgressCurveFilled = false,
    this.showOutOfScoreFormat = true,
    this.isRoundOffScore = true,
    this.isRoundOffScoreWhileProgress = true,
    this.scoreAnimationDuration = const Duration(seconds: 2),
    this.scoreTextAnimationDuration = const Duration(milliseconds: 800),
    this.scoreTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      height: 1,
    ),
  }) : super(key: key);

  /// The final value for the progress arc to stop.
  final double score;

  /// The maximum possible score or value.
  final double maxScore;

  /// The height of the progress arc.
  final double arcHeight;

  /// The width of the progress arc.
  final double arcWidth;

  /// The thickness of the background arc.
  final double backgroundArcStrokeThickness;

  /// The thickness of the progress arc.
  final double progressArcStrokeThickness;

  /// The minimum font size for the score text.
  final double minScoreTextFontSize;

  /// The maximum font size for the score text.
  final double maxScoreTextFontSize;

  /// The background color of the progress arc.
  final Color arcBackgroundColor;

  /// List of colors for a gradient effect on the progress arc.
  final List<Color> arcProgressGradientColors;

  /// Whether to enable a stepwise animation effect when the score changes.
  final bool enableStepperEffect;

  /// Whether to round the edges of the progress arc.
  final bool isRoundEdges;

  /// Whether to fill the progress arc with color.
  final bool isPrgressCurveFilled;

  /// Whether to show the "/maxScore" format after the score when animation completes.
  final bool showOutOfScoreFormat;

  /// Whether to round off the score value.
  final bool isRoundOffScore;

  /// Whether to round off the score value while the progress is ongoing.
  final bool isRoundOffScoreWhileProgress;

  /// The duration of the score animation.
  final Duration scoreAnimationDuration;

  /// The duration of the score text animation.
  final Duration scoreTextAnimationDuration;

  /// The text style for the score text.
  final TextStyle scoreTextStyle;

  @override
  State<PrimaryArcAnimationComponent> createState() =>
      _PrimaryArcAnimationComponentState();
}

class _PrimaryArcAnimationComponentState
    extends State<PrimaryArcAnimationComponent> with TickerProviderStateMixin {
  late AnimationController scoreProgressController;
  late Animation<double> scoreProgressAnimation;
  late Tween<double> scoreProgressTween;

  late AnimationController fontSizeController;
  late Animation<double> fontSizeAnimation;
  late Tween<double> fontTween;

  @override
  void initState() {
    assert(
      widget.score <= widget.maxScore,
      'score must be lesser or equal to maxScore',
    );
    assert(
      widget.arcHeight > 0,
      'arc height must be greater than zero',
    );
    assert(
      widget.arcWidth > 0,
      'arc width must be greater than zero',
    );

    scoreProgressController = AnimationController(
      vsync: this,
      duration: widget.scoreAnimationDuration,
    );
    scoreProgressTween = Tween<double>(
      begin: 0,
      end: widget.score,
    );
    scoreProgressAnimation =
        scoreProgressTween.animate(scoreProgressController);
    scoreProgressController.forward();

    scoreProgressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fontSizeController.forward();
      }
    });

    fontSizeController = AnimationController(
      vsync: this,
      duration: widget.scoreTextAnimationDuration,
    );

    fontTween = Tween<double>(
      begin: widget.minScoreTextFontSize,
      end: widget.maxScoreTextFontSize,
    );

    fontSizeAnimation = fontTween.animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: fontSizeController,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    scoreProgressController.dispose();
    fontSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.arcHeight / 2 + widget.backgroundArcStrokeThickness,
      width: widget.arcWidth + widget.backgroundArcStrokeThickness,
      // decoration: BoxDecoration(border: Border.all()),
      child: AnimatedBuilder(
        animation: scoreProgressAnimation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomPaint(
                painter: BasicArcProgressPainter(
                  currentValue: scoreProgressAnimation.value,
                  destinatonValue: widget.score,
                  totalValue: widget.maxScore,
                  arcHeight: widget.arcHeight,
                  arcWidth: widget.arcWidth,
                  backgroundArcStrokeThickness:
                      widget.backgroundArcStrokeThickness,
                  progressArcStrokeThickness: widget.progressArcStrokeThickness,
                  arcBackgroundColor: widget.arcBackgroundColor,
                  arcProgressGradientColors: widget.arcProgressGradientColors,
                  enableStepperEffect: widget.enableStepperEffect,
                  isRoundEdges: widget.isRoundEdges,
                  isPrgressCurveFilled: widget.isPrgressCurveFilled,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter, // Adjust alignment as needed
                child: AnimatedBuilder(
                  animation: fontSizeController,
                  builder: (context, child) {
                    var score = scoreProgressAnimation.value
                        .toStringAsFixed(widget.isRoundOffScore ? 0 : 2);
                    if (scoreProgressController.status !=
                        AnimationStatus.completed) {
                      score = scoreProgressAnimation.value.toStringAsFixed(
                        widget.isRoundOffScoreWhileProgress ? 0 : 2,
                      );
                    }
                    final outOf = (scoreProgressController.status ==
                                AnimationStatus.completed &&
                            widget.showOutOfScoreFormat)
                        ? '/${widget.maxScore.toStringAsFixed(0)}'
                        : '';
                    return Transform(
                      transform: Matrix4.identity()
                        ..rotateY(fontSizeAnimation.value * pi)
                        ..rotateY(fontSizeAnimation.value * pi),
                      alignment: FractionalOffset.center,
                      child: Text(
                        score + outOf,
                        style: widget.scoreTextStyle.copyWith(
                          fontSize: fontSizeAnimation.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
