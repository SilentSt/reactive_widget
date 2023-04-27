import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

abstract class ReactiveWidget<T extends ReactiveWidgetModel> extends StatefulWidget {
  const ReactiveWidget({Key? key}) : super(key: key);

  ///используется для создания екземпляра `ReactiveWidgetModel`
  T widgetModelBuilder(BuildContext context);

  ///используется для отрисовки UI
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

  @override
  void dispose() {
    _wm.dispose();
    super.dispose();
  }

  ///
  /// Do not override this function, use instead `buildView`
  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    return widget.buildView(context, _wm);    
  }
}
