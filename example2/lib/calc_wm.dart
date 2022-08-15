import 'package:flutter/cupertino.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_wm.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class CalcWidgetModel extends ReactiveWidgetModel<int> {
  CalcWidgetModel();

  final TextEditingController x1 = TextEditingController();
  final TextEditingController x2 = TextEditingController();
}
