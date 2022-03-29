part of 'timer_bloc.dart';


/*
if the state is TimerInitial the user will be able to start the timer.
if the state is TimerRunInProgress the user will be able to pause and reset the timer as well as see the remaining duration.
if the state is TimerRunPause the user will be able to resume the timer and reset the timer.
if the state is TimerRunComplete the user will be able to reset the timer.
*/

@immutable
abstract class TimerState extends Equatable {
  final int duration; 

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration]; 
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}