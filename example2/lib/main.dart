
import 'package:flutter/material.dart';

import 'calc_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Flexible(child: CalcWidget()),
          Flexible(child: CalcWidget()),
        ],
      )      
    );
  }
}
