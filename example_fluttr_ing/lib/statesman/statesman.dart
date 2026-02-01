import 'package:flutter/material.dart';
import 'package:fluttr/statesman/counter_stream.dart';

class Statesman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CounterScreen());
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterStream _counter = CounterStream();
  late Stream<int> _countStream;

  @override
  void initState() {
    super.initState();
    _countStream = _counter.countStream;
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream Example')),
      body: Center(
        child: StreamBuilder<int>(
          stream: _countStream,
          builder: (context, snapshot) {
            return Text(
              'Count: ${snapshot.data ?? 0}',
              style: TextStyle(fontSize: 30),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
