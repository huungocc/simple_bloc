import 'package:simple_bloc/bloc/bloc.dart';

abstract class CounterState extends BlocState {}

class CounterInitial extends CounterState {
  final int count;
  CounterInitial(this.count);
}

class CounterChanged extends CounterState {
  final int count;
  CounterChanged(this.count);
}