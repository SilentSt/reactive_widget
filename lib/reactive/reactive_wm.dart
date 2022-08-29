import 'dart:async';

import 'package:flutter/material.dart';

abstract class ReactiveWidgetModel<T> {
  late final StreamController<T> _streamController;
  late final T? initialData;
  late final BuildContext context;

  List<Function> get initialActions => [];

  Stream<T> get stream => _streamController.stream;

  @mustCallSuper
  void init(BuildContext context) {
    this.context = context;
    if (setInitialData() != null) {
      initialData = setInitialData();
    } else {
      initialData = null;
    }

    _streamController = setDataSource();
    for (final action in initialActions) {
      action();
    }
  }

  StreamController<T> setDataSource() {
    return StreamController.broadcast();
  }

  T? setInitialData() {
    return null;
  }

  @protected
  void event(T event) {
    _streamController.add(event);
  }

  @mustCallSuper
  void dispose() {
    _streamController.close();
  }
}
