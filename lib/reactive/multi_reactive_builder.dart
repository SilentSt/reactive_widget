import 'package:flutter/cupertino.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_container.dart';

enum MultipleSelectContainerEnumerator {
  available,
  selected;
}

typedef MultiReactiveBuilder<T, Z> = Widget Function(
  BuildContext ctx,
  Map<Z, ReactiveContainer<T?>> containers,
);

class MultiReactiveBuilderWidget<T, Z> extends StatefulWidget {
  const MultiReactiveBuilderWidget({
    Key? key,
    required this.builder,
    required this.containers,
    this.displayLoadingWidget = true,
    this.loadingWidget,
  }) : super(key: key);

  ///основной билдер отвечающий за отрисовку UI
  final MultiReactiveBuilder<T, Z> builder;

  ///контейнер который отвечает за хранение значения представляет собой своеобразную модель,
  ///этот виджет подписывается на этот контейнер и когда конейнер уведомляет об изменениях
  ///UI перерисовывается
  final Map<Z, ReactiveContainer<T?>> containers;

  ///опциональный параметр, базовое значение - `true`, позволяет отрисовывать специальный виджет "Загрузки",
  ///когда `container.isBusy==true` он будет отображаться вместов `builder`
  final bool displayLoadingWidget;

  ///опциональный параметр позволяющий изменить виджет который будет отрисовываться во время загрузки
  ///если не указан, то будет отображаться - `CupertinoActivityIndicator(color: CupertinoColors.activeBlue)`
  final Widget? loadingWidget;
  @override
  State<MultiReactiveBuilderWidget<T, Z>> createState() =>
      _MultiReactiveBuilderWidgetState<T, Z>();
}

class _MultiReactiveBuilderWidgetState<T, Z>
    extends State<MultiReactiveBuilderWidget<T, Z>> {
  @override
  void initState() {
    for (final container in widget.containers.values) {
      container.addListener(() {
        if (mounted) setState(() {});
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.containers.values
            .where((element) => element.isBusy)
            .isNotEmpty) &&
        widget.displayLoadingWidget) {
      return widget.loadingWidget ??
          const CupertinoActivityIndicator(
            color: CupertinoColors.activeBlue,
          );
    }
    return widget.builder(context, widget.containers);
  }
}
