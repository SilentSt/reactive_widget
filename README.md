## Getting started

Используйте Provider для реализации

## Example

main.dart

```dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbeu_pattern_test/test_widget.dart';
import 'package:sbeu_pattern_test/test_wm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        create: (context) => TestWidgetModel(TestWidget()),
        child: const App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: context.read<TestWidgetModel>().widget,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final reactiveProvider = context.read<TestWidgetModel>();
        reactiveProvider.update(
          Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          ),
        );
      }),
    );
  }
}
```
test_widget.dart

```dart

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color> {
  TestWidget({
    Key? key,
  }) : super(
          key: key,
          initialValue: Colors.redAccent,
        );

  @override
  Widget build(BuildContext context) {
    if (needInitializeStream) initState(context);
    return Center(
      child: SizedBox(
        height: 200,
        width: 200,
        child: ColoredBox(color: val!),
      ),
    );
  }
}
```

test_wm.dart
```dart
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel<T> {
  TestWidgetModel(this._widget);

  final ReactiveWidget _widget;

  ReactiveWidget get widget => _widget;

  void update(T event) {
    _widget.wm.event(event);
  }
}
```
