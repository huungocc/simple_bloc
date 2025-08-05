import 'dart:async';

abstract class BlocEvent {}

abstract class BlocState {}

// Core BloC
abstract class Bloc<Event extends BlocEvent, State extends BlocState> {
  final _eventController = StreamController<Event>();
  final _stateController = StreamController<State>.broadcast();

  late State _state;

  Bloc(State initialState) {
    _state = initialState; // Khởi tạo State

    // Nhận Event => phát ra State
    _eventController.stream.listen((event) async {
      await for (final newState in mapEventToState(event)) {
        _state = newState;
        _stateController.add(_state);
      }
    });
  }

  // Getters
  State get state => _state;
  Stream<State> get stream => _stateController.stream;

  // Nhận Event
  void add(Event event) => _eventController.add(event);

  Stream<State> mapEventToState(Event event);

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
