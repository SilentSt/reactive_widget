import 'dart:async';

import 'package:flutter/material.dart';

abstract class ReactiveWidgetModel<T> {
  late final StreamController<T> _streamController;
  late final T? initialData;
  late final BuildContext context;
  late final Stream<T>? _customStream;

  List<Function> get initialActions => [];

  Stream<T> get stream => _customStream ?? _streamController.stream;

  @mustCallSuper
  Future<void> init(BuildContext context) async {
    this.context = context;
    initialData = setInitialData();
    _customStream = await setCustomStream();
    if (_customStream == null) {
      _streamController = setDataSource();
    }
    for (final action in initialActions) {
      action();
    }
  }

  StreamController<T> setDataSource() {
    return StreamController.broadcast();
  }

  Future<Stream<T>?> setCustomStream() async {
    return null;
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
