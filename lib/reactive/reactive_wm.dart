import 'dart:async';

import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class ReactiveWidgetModel<T> {
  ReactiveWidgetModel();

  late final ReactiveWidget _widget;

  ReactiveWidget get widget {
    // ignore: unnecessary_null_comparison
    if (_widget == null) {
      throw UnimplementedError('You need to call setWidget in initializer');
    }
    return _widget;
  }

  final StreamController<T> _controller = StreamController<T>.broadcast();

  Stream<T> get controller => _controller.stream;

  void setWidget(ReactiveWidget widget) {
    _widget = widget;
  }

  void event(T value) {
    _controller.add(value);
  }

  void dispose(){
    _controller.close();
  }
}
