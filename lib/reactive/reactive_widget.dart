import 'package:flutter/material.dart';
import 'package:reactive_widget/reactive/reactive_wm.dart';

// ignore: must_be_immutable
abstract class ReactiveWidget<T> extends StatelessWidget {
  ReactiveWidget({
    Key? key,
    this.initialValue,
  }) : super(key: key) {
    wm = ReactiveWidgetModel<T>();
    stream = wm.controller;
    stream.listen((event) {});
  }

  late final ReactiveWidgetModel<T> wm;
  late final Stream<T> stream;
  final T? initialValue;

  T? val;
  bool needInitializeStream = true;
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
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

  void update(T event) {
    wm.event(event);
  }

  void _subscribe(BuildContext context) {
    stream.listen((event) {
      val = event;
      (context as Element).markNeedsBuild();
    });
  }
}
