import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_test/models/app_state.dart';
import 'reducers/app_state_reducer.dart';
import 'containers/home.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

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

  final store = Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: [persistor.createMiddleware()],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        )
    );
  }
}

