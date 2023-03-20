import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_container.dart';

typedef ReactiveBuilder<T> = Widget Function(BuildContext ctx, ReactiveContainer<T?> container);

class ReactiveBuilderWidget<T> extends StatefulWidget {
  const ReactiveBuilderWidget({
    Key? key,
    required this.builder,
    required this.container,
  }) : super(key: key);

  final ReactiveBuilder<T> builder;
  final ReactiveContainer<T?> container;

  @override
  State<ReactiveBuilderWidget<T>> createState() => _ReactiveBuilderWidgetState<T>();
}

class _ReactiveBuilderWidgetState<T> extends State<ReactiveBuilderWidget<T>> {
  @override
  void initState() {
    widget.container.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.container);
  }
}
