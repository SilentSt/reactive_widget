import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color> {
  TestWidget({
    required super.wm,
    super.initialValue,
    super.key,
    required super.stream,
  });

  TestWidgetModel get model => (wm as TestWidgetModel);

  @override
  Widget build(BuildContext context) {
    if (needInitializeStream.value!) initState(context);
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: ColoredBox(
          color: container.value ?? Colors.amber,
        ),
      ),
    );
  }
}
