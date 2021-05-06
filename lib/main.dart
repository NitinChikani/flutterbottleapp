import 'package:bottle_app/bottal.dart';
import 'package:flutter/material.dart';
import 'tracking_input.dart';
import 'package:flutter/services.dart';

void main() {
  ///let's remove the Android buttons. For the purpose of this app, we don't need/want em on screen!
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: TrackingInput(),
    );
  }
}
