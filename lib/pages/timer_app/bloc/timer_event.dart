import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const <dynamic>[]]) : super(props);
}

class Start extends TimerEvent {
  final int duration;

  Start({@required this.duration}) : super([duration]);

  @override
  String toString() => "Start { duration: $duration }";
}

class Pause extends TimerEvent {
  @override
  String toString() => "Pause";
}

class Reset extends TimerEvent {
  @override
  String toString() => "Reset";
}

class Resume extends TimerEvent {
  @override
  String toString() => "Resume";
}

class Tick extends TimerEvent {
  final int duration;

  Tick({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";
}
