// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color> {
  TestWidget({
    Key? key,
  }) : super(
          key: key,
          initialValue: Colors.redAccent,
        );

  @override
  Widget build(BuildContext context) {
    if (needInitializeStream) initState(context);
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: ColoredBox(color: val!),
      ),
    );
  }
}