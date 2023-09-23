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

## Features

- **Customizable:** You can customize the appearance of the score visualization, including the color, size, and animation.

- **Animated:** The package includes animations to make the score visualization engaging and interactive.

- **Easy to Use:** Integrating this package into your Flutter project is straightforward and requires minimal setup.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  your_package_name: ^1.0.0 # Use the latest version
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

## Additional information

##1. Before submit PR
Before submit any PR, you need to set githook on your machine by paste and run this command from your terminal at root project 
```
git config core.hooksPath .githooks
```
