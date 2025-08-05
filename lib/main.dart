import 'package:flutter/material.dart';
import 'package:simple_bloc/bloc/bloc_builder.dart';
import 'package:simple_bloc/bloc/bloc_listener.dart';
import 'package:simple_bloc/bloc/bloc_provider.dart';
import 'package:simple_bloc/counter_bloc.dart';
import 'package:simple_bloc/counter_event.dart';
import 'package:simple_bloc/counter_state.dart';

void main() {
  runApp(CounterPage());
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterBody(),
    );
  }
}

class CounterBody extends StatefulWidget {
  const CounterBody({super.key});

  @override
  State<CounterBody> createState() => _CounterBodyState();
}

class _CounterBodyState extends State<CounterBody> {
  late final CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _counterBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Counter BloC'),
        ),
        body: BlocListener<CounterState>(
          stream: _counterBloc.stream,
          initialState: _counterBloc.state,
          listener: (context, state) {
            if (state is CounterChanged && state.count == 10) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đếm đến 10!')),
              );
            }
          },
          child: BlocBuilder<CounterState>(
            stream: _counterBloc.stream,
            initialState: _counterBloc.state,
            builder: (context, state) {
              int count = 0;
              if (state is CounterInitial) {
                count = state.count;
              } else if (state is CounterChanged) {
                count = state.count;
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Count: $count',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () => _counterBloc.add(DecrementEvent()),
                          child: Icon(Icons.remove),
                        ),
                        FloatingActionButton(
                          onPressed: () => _counterBloc.add(ResetEvent()),
                          child: Icon(Icons.refresh),
                        ),
                        FloatingActionButton(
                          onPressed: () => _counterBloc.add(IncrementEvent()),
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}