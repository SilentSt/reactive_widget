## Getting started

Используйте Provider для реализации

## Example

main.dart

```dart
import 'dart:math';
import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        create: (ctx) => TestWidgetModel(),
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
        reactiveProvider.event(
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

// ignore_for_file: must_be_immutable

import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<Color> {
  TestWidget({
    Key? key,
    required TestWidgetModel wm,
  }) : super(
          key: key,
          initialValue: Colors.redAccent,
          wm: wm,
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
import 'package:example/test_widget.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_wm.dart';

class TestWidgetModel extends ReactiveWidgetModel<Color> {
  TestWidgetModel() {
    init();
  }

  void init() {
    setWidget(TestWidget(wm: this));
  }
}

```
