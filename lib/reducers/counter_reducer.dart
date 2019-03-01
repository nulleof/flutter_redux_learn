
import 'package:redux/redux.dart';
import 'package:flutter_redux_test/actions/actions.dart';

final counterReducer = combineReducers<int>([
  TypedReducer<int, Increment>(_increment),
  TypedReducer<int, Decrement>(_decrement),
]);

int _increment(int state, action) {
  return state + 1;
}

int _decrement(int state, action) {
  return state - 1;
}