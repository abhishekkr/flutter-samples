import 'package:flutter/material.dart';
import 'package:fluttr/common/page_transition.dart';
import 'package:fluttr/codelabs/first_flutter_app.dart';
import 'package:fluttr/wotw/content.dart';

void main() => runApp(FluttrApp());

class FluttrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fluttr',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: PageContent(),
    );
  }
}

class PageContent extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Fluttr-ing'),
        ),
        body: Container(
                alignment: Alignment.center,
                color: Colors.redAccent,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Codelabs: Randome Words",
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          backgroundColor: Colors.white,       // Background color
                          foregroundColor: Colors.amber,     // Text color
                        ),
                        onPressed: () {
                          Navigator.of(context).push(RouteTransitionSimple(widget: RandomWords()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    SizedBox(height: 25.0),
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Widget of the Week",
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          backgroundColor: Colors.white,       // Background color
                          foregroundColor: Colors.amber,     // Text color
                        ),
                        onPressed: () {
                          Navigator.of(context).push(RouteTransitionSimple(widget: WidgetOfTheWeek()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    SizedBox(
                      height: 250.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Text("licensed under: CC BY-SA"),
                    ),
                  ],
                ), // <<ROW/>
              ), // <Container/>
    );
  }
}
