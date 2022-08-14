import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_widget/reactive_provider.dart';
import 'package:reactive_widget/reactive_widget.dart';

import 'test_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider(
        create: (context) => ReactiveProvider(
          create: (context) {},
        ),
        child: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final child = TestWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => child.update(
          Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          ),
        ),
      ),
    );
  }
}
