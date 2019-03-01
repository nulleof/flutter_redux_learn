import 'package:meta/meta.dart';

@immutable
class AppState {
  final int counter;

  AppState({this.counter = 0});

  AppState copyWith({int counter}) {
    return AppState(
      counter: counter ?? this.counter,
    );
  }

  @override
  int get hashCode => counter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppState && counter == other.counter;

  @override
  String toString() {
    return 'AppState{counter: $counter}';
  }

  // It's required for persistor
  static AppState fromJson(dynamic json) => AppState(counter: json["counter"]);

  dynamic toJson() => {'counter': counter};
}
