import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_test/models/app_state.dart';
import 'package:flutter_redux_test/selectors/selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_test/actions/actions.dart';

enum CounterActions { plus, munus }

class Home extends StatelessWidget {
  final WidgetBuilder devDrawerBuilder;

  Home({Key key, this.devDrawerBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(
          endDrawer: devDrawerBuilder != null ? devDrawerBuilder(context) : null,
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
                  onPressed: () => vm.onActionButton(CounterActions.plus),
                ),
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => vm.onActionButton(CounterActions.munus),
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
  final Function(CounterActions) onActionButton;

  _ViewModel({
    @required this.counter,
    @required this.onActionButton,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      counter: counterSelector(store.state),

      onActionButton: (action) {
        print("actions performed $action}");
        if (action == CounterActions.plus) {
          store.dispatch(Increment());
        } else if (action == CounterActions.munus) {
          store.dispatch(Decrement());
        }
      },
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