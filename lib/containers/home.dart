import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_test/models/app_state.dart';
import 'package:flutter_redux_test/selectors/selectors.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Some title'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter value is:',
                ),
                Text(
                  vm.counter.toString(),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () => print("plus"),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => print("minus"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final int counter;

  _ViewModel({@required this.counter});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      counter: counterSelector(store.state),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          counter == other.counter;

  @override
  int get hashCode => counter.hashCode;

  @override
  String toString() {
    return '_ViewModel{counter: $counter}';
  }
}