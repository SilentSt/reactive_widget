import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel extends ReactiveWidgetModel {
  final ReactiveContainer<Color> colorContainer = ReactiveContainer(initialValue: Colors.red, saveHistory: true);

  void updateColor() {
    colorContainer.update(
      Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      ),
    );
  }
}
