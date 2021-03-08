import 'package:flutter/material.dart';

class mainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Main Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "JosefinSans",
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
