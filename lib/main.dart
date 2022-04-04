import 'package:flutter/material.dart';
import 'package:meditation_app/screens/meditation_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),

               // primarySwatch: Colors.blue,
        // scaffoldBackgroundColor: Colors.lightBlue[100],

      home: MeditationAppScreen(),
    );
  }
}
