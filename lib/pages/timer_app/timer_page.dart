import 'package:bloc_example_apps/pages/timer_app/background.dart';
import 'package:bloc_example_apps/pages/timer_app/bloc/bloc.dart';
import 'package:bloc_example_apps/pages/timer_app/bloc/timer_bloc.dart';
import 'package:bloc_example_apps/pages/timer_app/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './actions.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (context) => TimerBloc(ticker: Ticker()), child: Timer());
  }
}

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Timer')),
        body: Stack(children: <Widget>[
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: Center(child: BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                    final String minutesStr = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final String secondsStr = (state.duration % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return Text(
                      '$minutesStr:$secondsStr',
                      style: Timer.timerTextStyle,
                    );
                  }))),
              BlocBuilder<TimerBloc, TimerState>(
                condition: (previusState, currentState) =>
                    currentState.runtimeType != previusState.runtimeType,
                builder: (context, state) => ActionsWidget(),
              )
            ],
          ),
        ]));
  }
}
