import 'dart:async';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

/// `ReactiveWidgetModel` is a class that allows you to create a `Stream` of events that can be listened
/// to by a `ReactiveWidget`
abstract class ReactiveWidgetModel<T> {
  /// `ReactiveWidgetModel` is a constructor that takes a `ReactiveModel` as an optional parameter
  /// 
  /// Args:
  ///   model (ReactiveModel): The model that this widget will be bound to.
  ReactiveWidgetModel({ReactiveModel? model}) {
    _model = model;
  }

  /// A nullable final variable that is initialized after the constructor is called.
  late final ReactiveWidget? _widget;

 /// A nullable final variable that is initialized after the constructor is called.
  late final ReactiveModel? _model;

  /// A getter that returns the model.
  ReactiveModel get model {
    if (_model == null) {
      throw UnimplementedError(
        'You need to initialize model field first in constructor',
      );
    }
    return _model!;
  }

  /// A getter that returns the widget.
  ReactiveWidget get widget {
    if (_widget == null) {
      throw UnimplementedError('You need to call setWidget in initializer');
    }
    return _widget!;
  }

  /// Creating a `StreamController` that will be used to create a `Stream` of events.
  final StreamController<T> _controller = StreamController<T>.broadcast();

  /// Returning the `Stream` of events.
  Stream<T> get controller => _controller.stream;

  /// `setWidget` is a function that takes a `ReactiveWidget` as a parameter and sets the `_widget`
  /// variable to the value of the parameter
  /// 
  /// Args:
  ///   widget (ReactiveWidget): The widget that will be used to display the data.
  void setWidget(ReactiveWidget widget) {
    _widget = widget;
  }

  /// `event` is a function that takes a value of type `T` and adds it to the stream
  /// 
  /// Args:
  ///   value (T): The data to send to the stream.
  void event(T value) {
    _controller.add(value);
  }

  /// `_controller.close()`
  /// 
  /// This function is called when the widget is removed from the widget tree
  void dispose() {
    _controller.close();
  }
}
