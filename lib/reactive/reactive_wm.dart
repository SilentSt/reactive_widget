import 'dart:async';

import 'package:flutter/material.dart';


abstract class ReactiveWidgetModel<T> {

  late final StreamController<T> _streamController;

  /// its initial data, you can set it in `setInitialData` 
  late final T? initialData;

  /// its context from `ReactiveWidget`, you can use it for some dialogs and so on
  late final BuildContext context;

  /// use it if you need to do some actions while widget initing
  List<Function> get initialActions => [];

  /// main stream data `T`, you have no need to do some updates in your `ReactiveWidget` if you are using only this stream`s data
  Stream<T> get stream => _streamController.stream;

  /// do not override this function
  /// you have special methods to init data and set initial actions
  @mustCallSuper
  void init(BuildContext context) {
    this.context = context;
    initialData = setInitialData();
    _streamController = StreamController.broadcast();
    for (final action in initialActions) {
      action();
    }
  }

  /// here you can set initial data of your stream
  T? setInitialData() {
    return null;
  }

  /// do not call it from your `ReactiveWidget`, use it localy in this file
  @protected
  void event(T event) {
    _streamController.add(event);
  }

  /// it`s diposes stream
  @mustCallSuper
  void dispose() {
    _streamController.close();
  }
}
