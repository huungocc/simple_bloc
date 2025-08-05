import 'package:simple_bloc/bloc/bloc.dart';
import 'package:simple_bloc/counter_event.dart';
import 'package:simple_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _counter = 0;

  CounterBloc() : super(CounterInitial(0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      _counter++;
      yield CounterChanged(_counter);
    } else if (event is DecrementEvent) {
      _counter--;
      yield CounterChanged(_counter);
    } else if (event is ResetEvent) {
      _counter = 0;
      yield CounterChanged(_counter);
    }
  }
}