import 'package:flutter/material.dart';
import 'package:digital_waqt_azan/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Waqt Azan',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Urdu',
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
