import 'dart:math';

import 'package:example/test_widget.dart';
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