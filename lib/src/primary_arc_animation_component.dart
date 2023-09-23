import 'dart:math';

import 'package:flutter/material.dart';
import 'package:score_progress_pretty_display/src/arc_progress_painter_types/basic_arc_progress_painter.dart';

/// This is component represents basic progress arc with animation and score text
/// [PrimaryArcAnimationComponent] expects some required named parameters and optional named parameters
/// [score] is the final value for progress bar to stop
/// [maxScore] is the maximum value for example : 10/100 where 10 is score and 100 is max score
///
class PrimaryArcAnimationComponent extends StatefulWidget {
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
    this.isRoundOfScoreWhileProgress = true,
    this.scoreAnimationDuration = const Duration(seconds: 2),
    this.scoreTextAnimationDuration = const Duration(milliseconds: 800),
    this.scoreTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      height: 1,
    ),
  }) : super(key: key);

  final double score;
  final double maxScore;

  final double arcHeight;
  final double arcWidth;

  final double backgroundArcStrokeThickness;
  final double progressArcStrokeThickness;

  final double minScoreTextFontSize;
  final double maxScoreTextFontSize;

  final Color arcBackgroundColor;
  final List<Color> arcProgressGradientColors;

  final bool enableStepperEffect;
  final bool isRoundEdges;
  final bool isPrgressCurveFilled;

  final bool showOutOfScoreFormat;
  final bool isRoundOffScore;
  final bool isRoundOfScoreWhileProgress;

  final Duration scoreAnimationDuration;
  final Duration scoreTextAnimationDuration;
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
                    progressArcStrokeThickness:
                        widget.progressArcStrokeThickness,
                    arcBackgroundColor: widget.arcBackgroundColor,
                    arcProgressGradientColors: widget.arcProgressGradientColors,
                    enableStepperEffect: widget.enableStepperEffect,
                    isRoundEdges: widget.isRoundEdges,
                    isPrgressCurveFilled: widget.isPrgressCurveFilled,
                  ),
                ),
                Align(
                  alignment:
                      Alignment.bottomCenter, // Adjust alignment as needed
                  child: AnimatedBuilder(
                    animation: fontSizeController,
                    builder: (context, child) {
                      var score = scoreProgressAnimation.value
                          .toStringAsFixed(widget.isRoundOffScore ? 0 : 2);
                      if (scoreProgressController.status !=
                          AnimationStatus.completed) {
                        score = scoreProgressAnimation.value.toStringAsFixed(
                            widget.isRoundOfScoreWhileProgress ? 0 : 2);
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
          }),
    );
  }
}
