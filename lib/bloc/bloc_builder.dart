import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocBuilder<S extends BlocState> extends StatelessWidget {
  final Stream<S> stream;
  final S initialState;
  final Widget Function(BuildContext context, S state) builder;

  const BlocBuilder({
    super.key,
    required this.stream,
    required this.initialState,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: stream,
      initialData: initialState,
      builder: (context, snapshot) => builder(context, snapshot.data!),
    );
  }
}

/*class BlocBuilder<B extends Bloc<dynamic, S>, S extends BlocState> extends StatefulWidget {
  final B bloc;
  final Widget Function(BuildContext context, S state) builder;
  final bool Function(S previous, S current)? buildWhen;

  const BlocBuilder({
    super.key,
    required this.bloc,
    required this.builder,
    this.buildWhen,
  });

  @override
  State<BlocBuilder<B, S>> createState() => _BlocBuilderState<B, S>();
}

class _BlocBuilderState<B extends Bloc<dynamic, S>, S extends BlocState> extends State<BlocBuilder<B, S>> {
  late S _previousState;
  late StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    _previousState = widget.bloc.state;
    _subscription = widget.bloc.stream.listen(_onNewState);
  }

  void _onNewState(S newState) {
    final shouldBuild = widget.buildWhen?.call(_previousState, newState) ?? true;
    if (shouldBuild) {
      setState(() {
        _previousState = newState;
      });
    } else {
      _previousState = newState;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _previousState);
  }
}*/

