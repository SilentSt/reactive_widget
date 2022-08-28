import 'package:flutter/material.dart';

import 'reactive_wm.dart';

abstract class ReactiveWidget<T, WM extends ReactiveWidgetModel<T>>
    extends StatelessWidget {
  const ReactiveWidget({
    Key? key,
  }) : super(key: key);

  Widget contentBuilder(BuildContext context, T data, WM wm);

  WM widgetModelBuilder(BuildContext context);

  Widget loadingBuilder(BuildContext context) {
    return const Center(
      child: RefreshProgressIndicator(),
    );
  }

  Widget errorBuilder(BuildContext context, dynamic error) {
    return Center(
      child: Text(
        'Error $error',
      ),
    );
  }

  Widget emptyBuilder(BuildContext context) {
    return const Center(
      child: Text('No content here'),
    );
  }

  @protected
  @override
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
