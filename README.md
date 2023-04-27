# reactive_widget

Эта библиотека нацелена упростить управление состояниями в вашем приложении, а также позволяет обновлять лишь необходимую часть на экране

# Основные объекты

* ReactiveWidget - используйте как `View`, не сильно отличается от обычного виджета, но позволяет избавиться от необходимости написания своей собственной системы связи с `ViewModel`
* ReactiveWidgetModel - используйте как `ViewModel`, используется для написания логики и хранении данных для вашего `ReactiveWidget`
* ReactiveContainer - используйте для хранения объектов на основе данных которых будет отрисовываться пользовательский интерфейс
* ReactiveBuiderWidget - используется для отрисовки пользовательского интерфейса, который будет автоматически изменяться при изменении значения у `ReactiveContainer`

# Пример

## Имплементация "View"

```
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
```

## Имплементация "ViewModel"

```
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sbeu_reactive_pattern/sbeu_reactive_pattern.dart';

class TestWidgetModel extends ReactiveWidgetModel {
  final ReactiveContainer<Color> colorContainer = ReactiveContainer(
    initialValue: Colors.red,
    saveHistory: true,
  );

  @override
  Future<void> onReady(BuildContext context) async {
    await updateColor();
  }

  Future<void> updateColor() async {
    colorContainer.updateAsync(
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          return Color.fromARGB(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          );
        },
      ),
    );
  }
}
```

# Советы
* Для обновления значения используйте методы `ReactiveContainer`: `update` и `updateAsync`.
* * Если вам нужно синхронно обновить интерфейс используйте `update`
* * Если вам нужно дождаться результата, а затем положить это значения в `ReactiveContainer`, лучше используйте `updateAsync`, передав в него Future<T>, что позволит контейнеру самостоятельно обновить значение, а также отрисовать пользователю виджет загрузки, пока идет ожидание нового значения
