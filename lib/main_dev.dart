import 'package:flutter/material.dart';
import 'package:flutter_redux_test/models/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'containers/application.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

void main() async {
  // Init persistor here
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(location: FlutterSaveLocation.sharedPreferences),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  var initialState = AppState();
  try {
    initialState = await persistor.load();
  } catch(error) {
    print("Use default state, cause error occured during load state: $error");
  }

  final store = DevToolsStore<AppState>(
    appReducer,
    initialState: initialState,
    middleware: [persistor.createMiddleware()],
  );

  runApp(Application(
      store: store,
      devDrawerBuilder: (context) {
        return Drawer(
          child: Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: ReduxDevTools(store),
          ),
        );
      },
  ));
}
