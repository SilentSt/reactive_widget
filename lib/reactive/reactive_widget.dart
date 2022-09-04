import 'package:flutter/material.dart';

import 'reactive_wm.dart';

/// `ReactiveWidget` is autoupdating widget when value of `strem` of your `ReactiveWidgetModel` changes
abstract class ReactiveWidget<T, WM extends ReactiveWidgetModel<T>>
    extends StatelessWidget {
  const ReactiveWidget({
    Key? key,
  }) : super(key: key);

  /// It`s your content widget which displays what you want, pass here your widget
  Widget contentBuilder(BuildContext context, T data, WM wm);

  /// Here you have to initialize your `ReactiveWidgetModel`
  WM widgetModelBuilder(BuildContext context);

  // It`s optional builder, you can override it if you want to customize your widget loading
  Widget loadingBuilder(BuildContext context) {
    return const Center(
      child: RefreshProgressIndicator(),
    );
  }

  // It`s optional builder, you can override it if you want to customize your widget has error while loading error
  Widget errorBuilder(BuildContext context, dynamic error) {
    return Center(
      child: Text(
        'Error $error',
      ),
    );
  }

  // It`s optional builder, you can override it if you want to customize your widget when it`s get no data
  Widget emptyBuilder(BuildContext context) {
    return const Center(
      child: Text('No content here'),
    );
  }

  /// Do not override this function, use instead `contentBuilder`
  @protected
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    final wm = widgetModelBuilder(context);
    wm.init(context);
    return StreamBuilder<T>(
      initialData: wm.initialData,
      stream: wm.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorBuilder(context, snapshot.error);
        } else if (!snapshot.hasData) {
          return loadingBuilder(context);
        } else if (snapshot.data == null) {
          return emptyBuilder(context);
        } else {
          return contentBuilder(context, snapshot.data as T, wm);
        }
      },
    );
  }
}
