import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocListener<S extends BlocState> extends StatefulWidget {
  final Stream<S> stream;
  final S initialState;
  final Widget child;
  final void Function(BuildContext context, S state) listener;

  const BlocListener({
    super.key,
    required this.stream,
    required this.initialState,
    required this.child,
    required this.listener,
  });

  @override
  State<BlocListener<S>> createState() => _BlocListenerState<S>();
}

class _BlocListenerState<S extends BlocState> extends State<BlocListener<S>> {
  late S _prevState;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _prevState = widget.initialState;
    _subscription = widget.stream.listen((state) {
      if (_prevState != state) {
        widget.listener(context, state);
        _prevState = state;
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/*
class BlocListener<B extends Bloc<dynamic, S>, S extends BlocState> extends StatefulWidget {
  final B bloc;
  final Widget child;
  final void Function(BuildContext context, S state) listener;
  final bool Function(S previous, S current)? listenWhen;

  const BlocListener({
    super.key,
    required this.bloc,
    required this.child,
    required this.listener,
    this.listenWhen,
  });

  @override
  State<BlocListener<B, S>> createState() => _BlocListenerState<B, S>();
}

class _BlocListenerState<B extends Bloc<dynamic, S>, S extends BlocState> extends State<BlocListener<B, S>> {
  late S _previousState;
  late StreamSubscription<S> _subscription;

  @override
  void initState() {
    super.initState();
    _previousState = widget.bloc.state;
    _subscription = widget.bloc.stream.listen(_onNewState);
  }

  void _onNewState(S newState) {
    final shouldListen = widget.listenWhen?.call(_previousState, newState) ?? true;
    if (shouldListen) {
      widget.listener(context, newState);
    }
    _previousState = newState;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
*/

