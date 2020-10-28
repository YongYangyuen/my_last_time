import 'package:flutter/material.dart';
import 'package:my_last_time/main.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: MyHomePage(title: 'Last Time'),
        title: Text(
          'My Last Time',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
        image: Image.asset('assets/clock.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(color: Colors.deepPurple),
        photoSize: MediaQuery.of(context).size.height * 0.25,
        loaderColor: Colors.pinkAccent);
  }
}
