import 'dart:async';

class CounterStream {
  final StreamController<int> _controller = StreamController<int>();
  int _count = 0;

  Stream<int> get countStream => _controller.stream;

  void increment() {
    _count++;
    _controller.add(_count);
  }

  void dispose() {
    _controller.close();
  }
}
