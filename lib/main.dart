import 'package:flutter/material.dart';
import 'file:///D:/Project/FlutterProject/uber/lib/all_screens/registration.dart';
import 'all_screens/loginscreen.dart';
import 'all_screens/mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: loginScreen.idScreen,
      routes: {
        registrationScreen.idScreen: (context) => registrationScreen(),
        loginScreen.idScreen: (context) => loginScreen(),
        mainScreen.idScreen: (context) => mainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
