import 'package:example/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_wm.dart';

class TestWidgetModel extends ReactiveWidgetModel<Color> {
  TestWidgetModel() {
    init();
  }

  void init() {
    setWidget(TestWidget(wm: this));
  }
}
