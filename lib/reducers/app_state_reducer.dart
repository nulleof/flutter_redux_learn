import 'package:flutter_redux_test/models/app_state.dart';
import 'counter_reducer.dart';

// Combine many small reducers into one
AppState appReducer(AppState state, action) {
  return AppState(
    counter: counterReducer(state.counter, action),
  );
}