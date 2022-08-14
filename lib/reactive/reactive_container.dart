
/// It's a container that can hold a value of type T, and it can notify listeners when the value changes
class ReactiveContainer<T> {
  /// It's a constructor that takes a value of type T and sets it to the value property.
  ReactiveContainer({this.value});
  /// It's a nullable type.
  T? value;
}
