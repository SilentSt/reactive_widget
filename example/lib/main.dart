import 'dart:math';
import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

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
