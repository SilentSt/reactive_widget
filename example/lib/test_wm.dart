import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel extends ReactiveWidgetModel {
  final ReactiveContainer<Color> colorContainer = ReactiveContainer(
    initialValue: Colors.red,
    saveHistory: true,
  );

  @override
  Future<void> onReady(BuildContext context) async {
    await updateColor();
  }

  Future<void> updateColor() async {
    colorContainer.updateAsync(
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          return Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          );
        },
      ),
    );
  }
}
