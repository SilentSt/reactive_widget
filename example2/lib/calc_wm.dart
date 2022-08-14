import 'package:flutter/cupertino.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_wm.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';
import 'calc_widget.dart';

class CalcWidgetModel extends ReactiveWidgetModel<int> {
  CalcWidgetModel() {
    init();
  }

  final TextEditingController x1 = TextEditingController();
  final TextEditingController x2 = TextEditingController();

  void init() {
    setWidget(CalcWidget(wm: this));
  }
}
