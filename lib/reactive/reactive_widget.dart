import 'package:flutter/material.dart';
import 'reactive_wm.dart';

// ignore: must_be_immutable
abstract class ReactiveWidget<T> extends StatelessWidget {
  ReactiveWidget({
    Key? key,
    this.initialValue,
    required ReactiveWidgetModel<T> wm,
  }) : super(key: key) {
    wm = wm;
    stream = wm.controller;
  }

  late final ReactiveWidgetModel<T> wm;
  late final Stream<T> stream;
  final T? initialValue;

  T? val;
  bool needInitializeStream = true;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(
      'You need to ovverride Widget build(BuildContext context){}',
    );
  }

  void initState(BuildContext context) {
    if (initialValue != null) {
      val ??= initialValue;
    }
    if (needInitializeStream) {
      _subscribe(context);
      needInitializeStream = false;
    }
  }

  void _subscribe(BuildContext context) {
    stream.listen((event) {
      val = event;
      (context as Element).markNeedsBuild();
    });
  }
}
