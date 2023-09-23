import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:score_progress_pretty_display/score_progress_pretty_display.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Credit Score',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
      body: const Center(
        child: PrimaryArcAnimationComponent(
          score: 77,
          maxScore: 100,
          arcHeight: 340,
          arcWidth: 340,
          backgroundArcStrokeThickness: 10,
          progressArcStrokeThickness: 10,
          enableStepperEffect: false,
          isRoundEdges: false,
          minScoreTextFontSize: 30,
          maxScoreTextFontSize: 50,
          isRoundOfScoreWhileProgress: true,
          isRoundOffScore: true,
          showOutOfScoreFormat: true,
          isPrgressCurveFilled: false,
          scoreAnimationDuration: Duration(seconds: 2),
          scoreTextAnimationDuration: Duration(milliseconds: 500),
          scoreTextStyle: TextStyle(fontWeight: FontWeight.normal, height: 1),
          arcBackgroundColor: Colors.black12,
          arcProgressGradientColors: [
            Colors.yellowAccent,
            Colors.greenAccent,
            Colors.green,
          ],
        ),
      ),
    );
  }
}
