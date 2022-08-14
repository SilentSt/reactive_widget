import 'package:flutter/material.dart';
import 'package:reactive_widget/reactive_wm.dart';

class ReactiveWidget<T> extends StatefulWidget {
  ReactiveWidget({
    Key? key,
    required this.element,
  }) : super(key: key) {
    wm = ReactiveWidgetModel<T>();
    stream = wm.controller;
  }

  late final ReactiveWidgetModel<T> wm;
  late final Stream<T> stream;
  final Widget Function(dynamic value) element;

  @override
  _ReactiveWidgetState createState() => _ReactiveWidgetState();
}

class _ReactiveWidgetState<T> extends State<ReactiveWidget<T>> {
  @override
  void initState() {
    widget.stream.listen(
      (event) {
        setState(
          () {
            val = event;
          },
        );
      },
    );
    super.initState();
  }

  T? val;
  @override
  Widget build(BuildContext context) {
    if (val == null) {
      return const CircularProgressIndicator();
    }
    return widget.element(val!);
  }
}
