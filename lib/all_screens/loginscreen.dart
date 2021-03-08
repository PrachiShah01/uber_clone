import 'package:flutter/material.dart';
import 'package:uber/all_wigets/progressDialog.dart';
import 'package:uber/main.dart';
import 'file:///D:/Project/FlutterProject/uber/lib/all_screens/registration.dart';
import 'mainscreen.dart';
import 'package:toast/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginScreen extends StatelessWidget {
  static const String idScreen = "loginScreen";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 65,
              ),
              Image(
                image: AssetImage('asset/images/icon.png'),
                width: 350,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Login as a Rider',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: "JosefinSans",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          Toast.show("Enter valid Email ID", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          Toast.show(
                              "Password must be atleast 6 characters", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }

                        loginAuthenticateUser(context);
                      },
                      color: Colors.amber,
                      textColor: Colors.white,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "JosefinSans",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(49),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            registrationScreen.idScreen, (route) => false);
                      },
                      child: Text(
                        'Don\'t have an account yet? Register here',
                        style: TextStyle(
                            fontFamily: "JosefinSans",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final User user = FirebaseAuth.instance.currentUser;
  void loginAuthenticateUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return progressDialog(
          message: "Authenticating, please wait...",
        );
      },
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        Toast.show("No user found for that email", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      } else if (e.code == 'wrong-password') {
        Toast.show("wrong password for that email address", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
      if (user != null) {
        userRef.child(user.uid).once().then(
              (value) => (DataSnapshot snap) {
                if (snap.value != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mainScreen()),
                  );
                }
              },
            );
      }
    }
  }
}
