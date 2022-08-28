import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color, TestWidgetModel> {
  const TestWidget({super.key});

  @override
  Widget contentBuilder(BuildContext context, Color data, TestWidgetModel wm) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: ColoredBox(
            color: data,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: wm.updateColor),
    );
  }

  @override
  TestWidgetModel widgetModelBuilder(BuildContext context) => TestWidgetModel();
}
