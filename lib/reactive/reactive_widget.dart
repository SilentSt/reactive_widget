import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

abstract class ReactiveWidget<T extends ReactiveWidgetModel> extends StatefulWidget {
  const ReactiveWidget({Key? key}) : super(key: key);

  T widgetModelBuilder(BuildContext context);
  Widget buildView(BuildContext context, T wm);

  @override
  State<ReactiveWidget<T>> createState() => _ReactiveWidgetState<T>();
}

class _ReactiveWidgetState<T extends ReactiveWidgetModel> extends State<ReactiveWidget<T>> {
  late final T _wm;

  @override
  void initState() {
    _wm = widget.widgetModelBuilder(context);
    _wm.onReady(context);
    super.initState();
  }

  /// Do not override this function, use instead `buildView`
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return widget.buildView(context, _wm);
  }
}
