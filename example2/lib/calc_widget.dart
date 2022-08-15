import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';
import 'calc_wm.dart';

class CalcWidget extends ReactiveWidget<int> {
  CalcWidget({Key? key})
      : super(
          key: key,
          wm: CalcWidgetModel(),
        );

  CalcWidgetModel get model => wm as CalcWidgetModel;

  @override
  Widget build(BuildContext context) {
    if (needInitializeStream.value!) initState(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          final result = int.parse(model.x1.text) + int.parse(model.x2.text);
          wm.event(result);
        }),
        body: SizedBox(
          height: 500,
          width: 800,
          child: Row(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: model.x1,
                ),
              ),
              const Text(" + "),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: model.x2,
                ),
              ),
              Text(" = ${container.value}")
            ],
          ),
        ));
  }
}
