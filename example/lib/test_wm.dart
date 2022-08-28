import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel extends ReactiveWidgetModel<Color> {
  @override
  Color? setInitialData() {
    return Colors.amber;
  }

  void updateColor() {
    event(
      Color.fromARGB(
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      ),
    );
  }
}
