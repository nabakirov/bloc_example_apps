import 'counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(), child: CounterWidget());
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
        appBar: AppBar(title: Text('bloc counter')),
        body: BlocBuilder<CounterBloc, int>(builder: (context, count) {
          return Center(child: Text('$count', style: TextStyle(fontSize: 24)));
        }),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.increment);
                  },
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: FloatingActionButton(
                  child: Icon(Icons.remove),
                  onPressed: () {
                    counterBloc.dispatch(CounterEvent.decrement);
                  },
                ))
          ],
        ));
  }
}
