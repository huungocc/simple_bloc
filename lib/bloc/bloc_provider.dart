import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;

  const BlocProvider({
    super.key,
    required super.child,
    required this.bloc,
  });

  static T of<T extends Bloc>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>();
    if (provider == null) {
      throw Exception('BlocProvider<$T> not found');
    }
    return provider.bloc;
  }

  @override
  bool updateShouldNotify(BlocProvider<T> oldWidget) => false;
}
