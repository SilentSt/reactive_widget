import 'package:example/test_wm.dart';
import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidget extends ReactiveWidget<TestWidgetModel> {
  const TestWidget({super.key});

  @override
  TestWidgetModel widgetModelBuilder(BuildContext context) => TestWidgetModel();

  @override
  Widget buildView(Object context, TestWidgetModel wm) {
    return Scaffold(
      body: Center(
        child: ReactiveBuilderWidget<Color>(
          builder: (ctx, container) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ColoredBox(
                    color: container.value ?? Colors.amber,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = container.history[index] ?? Colors.red;
                      return SizedBox(
                        height: 50,
                        width: 50,
                        child: ColoredBox(color: item),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(width: 20),
                    itemCount: container.history.length,
                  ),
                )
              ],
            );
          },
          container: wm.colorContainer,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: wm.updateColor),
          const SizedBox(width: 50),
          FloatingActionButton(onPressed: () => wm.colorContainer.pop()),
        ],
      ),
    );
  }
}
