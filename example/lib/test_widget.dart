import 'dart:math';

import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color> {
  TestWidget({
    super.initialValue,
    super.key,
  }) : super(
          wm: TestWidgetModel(),
        );

  TestWidgetModel get model => (wm as TestWidgetModel);

  @override
  Widget build(BuildContext context) {
    if (needInitializeStream.value!) initState(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: ColoredBox(
            color: container.value ?? Colors.amber,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        model.event(
          Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          ),
        );
      }),
    );
  }
}
