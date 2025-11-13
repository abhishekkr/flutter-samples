import 'package:flutter/material.dart';
import 'package:fluttr/common/page_transition.dart';
import 'package:fluttr/wotw/wotw_safearea.dart';
import 'package:fluttr/wotw/wotw_expanded.dart';
import 'package:fluttr/wotw/wotw_wrap.dart';
import 'package:fluttr/wotw/wotw_animated_container.dart';
import 'package:fluttr/wotw/wotw_opaque.dart';

class WidgetOfTheWeek extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Widget of the Week'),
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
                        child: Text("SafeArea",
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
                          Navigator.of(context).push(RouteTransitionSimple(widget: WotwSafeArea()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Expanded",
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
                          Navigator.of(context).push(RouteTransitionSimple(widget: WotwExpanded()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Wrap",
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
                          Navigator.of(context).push(RouteTransitionSimple(widget: WotwWrap()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Animated Container",
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
                          Navigator.of(context).push(RouteTransitionSimple(widget: WotwAnimatedContainer()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text("Opacity",
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
                          Navigator.of(context).push(RouteTransitionSimple(widget: WotwOpacity()));
                        },
                      ),
                    ), // <ButtonTheme/>
                    SizedBox(height: 25.0),
                    SizedBox(
                      height: 150.0,
                    ),
                    SizedBox(
                      child: Text("from youtube tutorials of flutter team and community"),
                    ),
                  ],
                ), // <<ROW/>
              ), // <Container/>
    );
  }
}
