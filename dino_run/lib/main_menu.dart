import 'package:dino_run/my_game_widget.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget titleText = Text(
      'DINO RUN',
      style: TextStyle(fontSize: 75, color: Colors.white),
    );
    final Widget playButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.greenAccent,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyGameWidget(title: 'DINO RUN'),
          ),
        );
      },
      child: Text(
        'PLAY',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final Widget menuPanel = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_menu_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.greenAccent.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [titleText, SizedBox(height: 15), playButton],
            ),
          ),
        ),
      ),
    );
    return Scaffold(body: menuPanel);
  }
}
