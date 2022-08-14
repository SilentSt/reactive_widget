import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_wm.dart';

class ReactiveProvider {
  static MultiProvider multi({
    required List<ReactiveWidgetModel> wms,
    Widget? child,
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    List<Provider> providers = [];
    for (final wm in wms) {
      providers.add(
        Provider(
          create: (context) => wm,
          dispose: (_, __) => wm.dispose(),
        ),
      );
    }
    return MultiProvider(
      providers: providers,
      builder: builder,
      child: child,
    );
  }

  static Provider single({
    Key? key,
    required ReactiveWidgetModel wm,
    Widget? child,
    Widget Function(BuildContext, Widget?)? builder,
  }) {
    return Provider(
      key: key,
      create: (context) => wm,
      builder: builder,
      child: child,
      dispose: (_, __) => wm.dispose(),
    );
  }
}
