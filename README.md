<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter package to display and visualize credit card scores, or any other type of score, in a visually appealing way.

## Previews

https://github.com/kartikeyaa-k/score-progress-pretty-display-package/assets/67781046/91747836-76a4-434d-8ea5-3d445674b3d9

https://github.com/kartikeyaa-k/score-progress-pretty-display-package/assets/67781046/bd7af7e4-3409-49f2-9c74-e1bc2b5de2bf

https://github.com/kartikeyaa-k/score-progress-pretty-display-package/assets/67781046/9b5270e7-61b7-46fe-95b0-4f3b50f86f2f

https://github.com/kartikeyaa-k/score-progress-pretty-display-package/assets/67781046/55f75e4e-f0ff-41cb-a85f-3759babbbba0

https://github.com/kartikeyaa-k/score-progress-pretty-display-package/assets/67781046/a37e7626-af33-4b66-b61a-9dc059d81c99


## Features

- **Customizable:** You can customize the appearance of the score visualization, including the color, size, and animation.

- **Animated:** The package includes animations to make the score visualization engaging and interactive.

- **Easy to Use:** Integrating this package into your Flutter project is straightforward and requires minimal setup.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  score_progress_pretty_display: ^1.0.0 # Use the latest version
```

## Usage


```dart
PrimaryArcAnimationComponent(
          score: 77.42,
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
          arcBackgroundColor: Colors.black12,
          arcProgressGradientColors: [
            Colors.yellowAccent,
            Colors.greenAccent,
            Colors.green,
          ],
        ),
```

## Example 

For a complete example, check the example directory included with this package.

## Contribution Guide

1. Feel free to reach out for feedback/discussions on kartikeya.199231@gmail.com

2. Before submit PR, you need to set githook on your machine by paste and run this command from your terminal at root project 
```
git config core.hooksPath .githooks
```

3. When you add new feature/fix issues, please make sure you update the documentation
```
dart doc .
```
4. If possible, I want to keep this package free from external dependencies.

## Roadmap 

1. I am planning to add new animations, curves in the next release.
