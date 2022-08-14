import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_container.dart';
import 'reactive_wm.dart';

// ignore: must_be_immutable
abstract class ReactiveWidget<T> extends StatelessWidget {
  ReactiveWidget({
    Key? key,
    this.initialValue,
    required this.wm,
    required this.stream,
  }) : super(key: key);

  final ReactiveWidgetModel<T> wm;
  final Stream<T> stream;
  final T? initialValue;

  final ReactiveContainer<T?> container = ReactiveContainer<T?>();
  final ReactiveContainer<bool> needInitializeStream = ReactiveContainer<bool>(value: true);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(
      'You need to ovverride Widget build(BuildContext context){}',
    );
  }

  void initState(BuildContext context) {
    if (initialValue != null) {
      container.value ??= initialValue;
    }
    if (needInitializeStream.value!) {
      _subscribe(context);
      needInitializeStream.value = false;
    }
  }

  void _subscribe(BuildContext context) {
    stream.listen((event) {
      container.value = event;
      (context as Element).markNeedsBuild();
    });
  }
}
