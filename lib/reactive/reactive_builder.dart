import 'package:flutter/cupertino.dart';
import 'package:sbeu_reactive_pattern/reactive/reactive_container.dart';

typedef ReactiveBuilder<T> = Widget Function(BuildContext ctx, ReactiveContainer<T?> container);

class ReactiveBuilderWidget<T> extends StatefulWidget {
  const ReactiveBuilderWidget({
    Key? key,
    required this.builder,
    required this.container,
    this.displayLoadingWidget = true,
    this.loadingWidget,
  }) : super(key: key);

  ///основной билдер отвечающий за отрисовку UI
  final ReactiveBuilder<T> builder;
  ///контейнер который отвечает за хранение значения представляет собой своеобразную модель,
  ///этот виджет подписывается на этот контейнер и когда конейнер уведомляет об изменениях
  ///UI перерисовывается
  final ReactiveContainer<T?> container;
  ///опциональный параметр, базовое значение - `true`, позволяет отрисовывать специальный виджет "Загрузки",
  ///когда `container.isBusy==true` он будет отображаться вместов `builder`
  final bool displayLoadingWidget;
  ///опциональный параметр позволяющий изменить виджет который будет отрисовываться во время загрузки
  ///если не указан, то будет отображаться - `CupertinoActivityIndicator(color: CupertinoColors.activeBlue)`
  final Widget? loadingWidget;
  @override
  State<ReactiveBuilderWidget<T>> createState() => _ReactiveBuilderWidgetState<T>();
}

class _ReactiveBuilderWidgetState<T> extends State<ReactiveBuilderWidget<T>> {
  @override
  void initState() {
    widget.container.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.container.isBusy && widget.displayLoadingWidget) {
      return widget.loadingWidget ??
          const CupertinoActivityIndicator(
            color: CupertinoColors.activeBlue,
          );
    }
    return widget.builder(context, widget.container);
  }
}
