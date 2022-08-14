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
    ReactiveWidget w1 = ReactiveWidget<String>(
      element: (value) => Text(value),
    );

    ReactiveWidget w2 = ReactiveWidget<Widget>(
      element: (val) => Container(
        child: val,
      ),
    );
    const img = NetworkImage(
      'https://gramm.sbeusilent.space/Load/fd33d249-c0f0-477c-a03f-fe0291bf5bd44c4e8c51-979b-4992-9a81-08592f824efe',
    );
    void sendEvent(ReactiveWidget w) {
      w.wm.event(img);
    }

    ReactiveWidget picture = ReactiveWidget<NetworkImage>(
      element: (val) => SizedBox(
        width: 400,
        height: 400,
        child: Image(
          image: val,
          fit: BoxFit.cover,
          loadingBuilder: (context, widget, chunk) {
            if (chunk == null) {
              sendEvent(picture);
              return widget;
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              picture,
              //w1,
              const SizedBox(height: 50),
              //w2,
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: () => w1.wm.event(Random().nextInt(10000).toString()),
            ),
            FloatingActionButton(
              onPressed: () => w2.wm.event(
                SizedBox(
                  height: 250,
                  width: 250,
                  child: ColoredBox(
                    color: Color.fromARGB(
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
