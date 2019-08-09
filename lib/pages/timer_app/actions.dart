import 'package:bloc_example_apps/pages/timer_app/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _mapStateToActionButtons(
          timerBloc: BlocProvider.of<TimerBloc>(context),
        ));
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
  }) {
    final TimerState state = timerBloc.currentState;
    if (state is Ready) {
      return [
        _buttonBuilder(
            timerBloc, Icons.play_arrow, Start(duration: state.duration))
      ];
    } else if (state is Running) {
      return [
        _buttonBuilder(timerBloc, Icons.pause, Pause()),
        _buttonBuilder(timerBloc, Icons.replay, Reset())
      ];
    } else if (state is Paused) {
      return [
        _buttonBuilder(timerBloc, Icons.play_arrow, Resume()),
        _buttonBuilder(timerBloc, Icons.replay, Reset())
      ];
    } else if (state is Finished) {
      return [_buttonBuilder(timerBloc, Icons.replay, Reset())];
    }
    return [];
  }

  Widget _buttonBuilder(TimerBloc timerBloc, IconData icon, TimerEvent event) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: () => timerBloc.dispatch(event),
    );
  }
}
