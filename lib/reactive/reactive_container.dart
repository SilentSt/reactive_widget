import 'dart:math';

import 'package:flutter/material.dart';

class ReactiveContainer<T> extends ChangeNotifier {
  ReactiveContainer({T? initialValue, bool saveHistory = false}) {
    _currentValue = initialValue;
    _saveHistory = saveHistory;
    notifyListeners();
  }

  T? _currentValue;
  bool _saveHistory = false;
  List<T?> _valuesHistory = [];
  int _currentValueIndex = 0;
  bool _isBusy = false;

  ///возвращает текущее значение контейнера
  T? get value => _currentValue;

  ///история значений
  ///
  ///если в конструкторе `saveHistory = false`
  ///или не определено, то история будет пустой и не будет сохраняться
  List<T?> get history => _valuesHistory;

  ///имеет значение `false`, если значение контейнера не в процессе обновления
  ///иначе вернет `true`
  bool get isBusy => _isBusy;

  ///возвращает позицию `value` в `history`
  int get currentValueIndex => _currentValueIndex - 1;

  ///синхронное обновляет значения контейнера
  void update(T newValue) async {
    _currentValue = newValue;
    if (_saveHistory) {
      _valuesHistory.add(newValue);
    }
    notifyListeners();
    _currentValueIndex = _valuesHistory.length;
  }

  ///асинхронное обновление значения, при этом если у `ReactiveBuilderWidget`,
  ///в котором используется этот контейнер параметр `displayLoadingWidget`
  ///не был определен как `false`, то во время ожидания значения будет отрисован загрузочный виджет
  ///`isBusy` автоматически сменяет значение сначала на `true`, а затем на `false` и уведомляет
  ///об этом `ReactiveBuilderWidget`
  Future<void> updateAsync(Future<T> newValue) async {
    _isBusy = true;
    notifyListeners();
    _currentValue = await newValue;
    if (_saveHistory) {
      _valuesHistory.add(_currentValue);
    }
    _isBusy = false;
    notifyListeners();
    _currentValueIndex = _valuesHistory.length;
  }

  ///позволяет очистить историю значений
  void cleanHistory() {
    _valuesHistory.clear();
    notifyListeners();
    _currentValueIndex = 0;
  }

  ///позволяет вернуться к предыдущему значению в истории
  bool pop({int? index}) {
    index ??= _currentValueIndex - 2;
    if (_valuesHistory.isEmpty || index > (_valuesHistory.length - 1) || index < 0) return false;
    _currentValue = _valuesHistory[index];
    notifyListeners();
    _currentValueIndex -= 1;
    return true;
  }

  ///если сравниваемый операнд не является `ReactiveContainer<T>`,
  ///то вернется `false`,
  ///иначе будут сравниваться `value` контейнеров
  @override
  bool operator ==(dynamic other) {
    if (other is! ReactiveContainer<T>) return false;
    return _currentValue == other;
  }

  @override
  int get hashCode => Random().nextInt(((_currentValue ?? '').toString().length));
}
