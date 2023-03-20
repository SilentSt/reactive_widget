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
  bool _isBusy = false;

  T? get value => _currentValue;
  List<T?> get history => _valuesHistory;
  bool get isBusy => _isBusy;

  void update(T newValue) async {
    notifyListeners();
    _currentValue = newValue;
    if (_saveHistory) {
      _valuesHistory.add(newValue);
    }
    notifyListeners();
  }

  Future<void> updateAsync(Future<T> newValue) async {
    _isBusy = true;
    notifyListeners();
    _currentValue = await newValue;
    _isBusy = false;
    notifyListeners();
  }

  void cleanHistory() {
    _valuesHistory.clear();
    notifyListeners();
  }

  bool pop({int? index}) {
    if (_valuesHistory.isEmpty || (index ?? 0) > (_valuesHistory.length - 1)) return false;
    final temp = _currentValue;
    _currentValue = _valuesHistory[index ?? _valuesHistory.length - 1];
    _valuesHistory.add(temp);
    notifyListeners();
    return true;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! T) return false;
    return _currentValue == other;
  }

  @override
  int get hashCode => Random().nextInt(((_currentValue ?? '').toString().length));
}
