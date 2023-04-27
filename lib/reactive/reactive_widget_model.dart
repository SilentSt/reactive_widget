import 'package:flutter/material.dart';
export 'reactive_container.dart';

abstract class ReactiveWidgetModel {
  ///используйте этот метод для инициализации первичных значений
  Future<void> onReady(BuildContext context) async {

  }

  ///этот метод вы можете использовать как обычный `dispose` у виджета во Flutter
  void dispose(){}
}
