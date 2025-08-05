import 'package:simple_bloc/bloc/bloc.dart';

class CounterEvent extends BlocEvent {}

class IncrementEvent extends CounterEvent {}
class DecrementEvent extends CounterEvent {}
class ResetEvent extends CounterEvent {}
