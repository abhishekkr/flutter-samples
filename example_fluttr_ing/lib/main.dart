import 'package:flutter/material.dart';
import 'package:fluttr/common/page_transition.dart';
import 'package:fluttr/codelabs/first_flutter_app.dart';
import 'package:fluttr/example_button.dart';
import 'package:fluttr/statesman/statesman.dart';
import 'package:fluttr/wotw/content.dart';

void main() => runApp(FluttrApp());

class FluttrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluttr',
      theme: ThemeData(primaryColor: Colors.red),
      home: PageContent(),
    );
  }
}

class PageContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fluttr-ing')),
      body: Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            ExampleButton(
              label: "Codelabs: Randome Words",
              onClickFn: () {
                Navigator.of(
                  context,
                ).push(RouteTransitionSimple(widget: RandomWords()));
              },
            ),
            SizedBox(height: 25.0),
            ExampleButton(
              label: "Widget of the Week",
              onClickFn: () {
                Navigator.of(
                  context,
                ).push(RouteTransitionSimple(widget: WidgetOfTheWeek()));
              },
            ),
            SizedBox(height: 25.0),
            ExampleButton(
              label: "States: Stream",
              onClickFn: () {
                Navigator.of(
                  context,
                ).push(RouteTransitionSimple(widget: Statesman()));
              },
            ),
            SizedBox(height: 250.0),
            SizedBox(height: 50.0, child: Text("licensed under: CC BY-SA")),
          ],
        ), // <<ROW/>
      ), // <Container/>
    );
  }
}
