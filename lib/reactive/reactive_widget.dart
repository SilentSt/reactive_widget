import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_container.dart';
import 'reactive_wm.dart';

/// ReactiveWidget is a StatelessWidget that can be used to build a widget that reacts to a stream
abstract class ReactiveWidget<T> extends StatelessWidget {
  /// A constructor.
  ReactiveWidget({
    Key? key,
    this.initialValue,
    required this.wm,
  }) : super(key: key);  

  /// A model that is used to pass data to the widget.
  final ReactiveWidgetModel<T> wm;

  /// A way to pass data to the widget.
  final T? initialValue;

  /// A container that holds the value of the stream.
  final ReactiveContainer<T?> container = ReactiveContainer<T?>();

  /// Used to prevent the stream from being initialized more than once.
  final ReactiveContainer<bool> needInitializeStream =
      ReactiveContainer<bool>(value: true);

  ///init state function

  /// Need to be override
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError(
      'You need to ovverride Widget build(BuildContext context){}',
    );
  }

  /// If the stream has not been initialized, then initialize it
  ///
  /// Args:
  ///   context (BuildContext): BuildContext
  void initState(BuildContext context) {
    if (initialValue != null) {
      container.value ??= initialValue;
    }
    if (needInitializeStream.value!) {
      _subscribe(context);
      needInitializeStream.value = false;
    }
  }

  /// _subscribe() is a function that takes a BuildContext as an argument and returns nothing. It listens
  /// to the stream and updates the container's value with the event. It then marks the context as
  /// needing to be rebuilt
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext of the widget that is using the StreamBuilder.
  void _subscribe(BuildContext context) {
    wm.controller.listen((event) {
      container.value = event;
      (context as Element).markNeedsBuild();
    });
  }
}
