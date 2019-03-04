import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_test/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_test/containers/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux_test/l10n/localizations.dart';

class Application extends StatelessWidget {
  final Store<AppState> store;
  final WidgetBuilder devDrawerBuilder;

  const Application({
    Key key,
    @required this.store,
    this.devDrawerBuilder,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
//          Title can only generates after localizations
//          onGenerateTitle: (BuildContext context) =>
//            AppLocalizations.of(context).title,
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('ru'),
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(devDrawerBuilder: devDrawerBuilder),
        )
    );
  }
}