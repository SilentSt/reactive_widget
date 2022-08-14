import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel<T> {
  TestWidgetModel(this._widget);

  final ReactiveWidget _widget;

  ReactiveWidget get widget => _widget;

  void update(T event) {
    _widget.wm.event(event);
  }
}
