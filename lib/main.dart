import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reactive_widget/reactive_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReactiveWidget<Color> coloredBox = ReactiveWidget<Color>(
      initialValue: Colors.amber,
      element: (val) => SizedBox(
        height: 300,
        width: 300,
        child: ColoredBox(
          color: val,
        ),
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: coloredBox,
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: () => coloredBox.wm.event(
                Color.fromARGB(
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
