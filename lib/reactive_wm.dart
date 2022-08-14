import 'dart:async';

class ReactiveWidgetModel<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  Stream<T> get controller => _controller.stream;

  void event(T value) {
    _controller.add(value);
  }
}
