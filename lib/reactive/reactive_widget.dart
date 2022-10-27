// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'reactive_wm.dart';

abstract class ReactiveWidget<T, WM extends ReactiveWidgetModel<T>> extends StatefulWidget {
  const ReactiveWidget({Key? key}) : super(key: key);

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
  Widget errorBuilder(BuildContext context, String error) {
    return Center(
      child: Text(
        'Error $error',
      ),
    );
  }

  @override
  _ReactiveWidget createState() => _ReactiveWidget<T, WM>();
}

/// `ReactiveWidget` is autoupdating widget when value of `strem` of your `ReactiveWidgetModel` changes
class _ReactiveWidget<T, WM extends ReactiveWidgetModel<T>> extends State<ReactiveWidget<T, WM>> {
  late final WM wm;

  @override
  void initState() {
    wm = widget.widgetModelBuilder(context);
    wm.init(context);
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
        
    //   },
    // );
    super.initState();
  }

  /// Do not override this function, use instead `contentBuilder`
  @protected
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: wm.initialData,
      stream: wm.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return widget.errorBuilder(context, snapshot.error.toString());
        } else if (!snapshot.hasData || snapshot.data == null) {
          return widget.loadingBuilder(context);
        } else {
          return widget.contentBuilder(context, snapshot.data as T, wm);
        }
      },
    );
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
