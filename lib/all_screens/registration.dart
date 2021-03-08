import 'package:flutter/material.dart';
import 'file:///D:/Project/FlutterProject/uber/lib/all_screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'package:uber/all_wigets/progressDialog.dart';
import 'package:uber/main.dart';

class registrationScreen extends StatelessWidget {
  static const String idScreen = "registrationScreen";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  String email, password, number, name;

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
                'Register as a Rider',
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
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
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
                      onChanged: (value) => name = value,
                    ),
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
                      onChanged: (value) => email = value,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.visiblePassword,
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
                      onChanged: (value) => password = value,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
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
                      onChanged: (value) => number = value,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (nameTextEditingController.text.length < 4) {
                          Toast.show(
                              "Name must be at least 4 character", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else if (!emailTextEditingController.text
                            .contains("@")) {
                          Toast.show("Enter valid Email ID", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else if (phoneTextEditingController.text.isEmpty) {
                          Toast.show("Phone Number is mandatory", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          Toast.show(
                              "Password must be atleast 6 characters", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        } else {
                          registerUser(context);
                        }
                      },
                      color: Colors.amber,
                      textColor: Colors.white,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Register',
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, loginScreen.idScreen, (route) => false);
                      },
                      child: Text(
                        'Already have an account? Login here',
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

  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;

  registerUser(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return progressDialog(
          message: "Registering, please wait...",
        );
      },
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      Toast.show("User acoount has not been created", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    if (user != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      userRef.child(user.uid).set(userDataMap);
      Toast.show("Your acoount has been created", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      Navigator.pushNamedAndRemoveUntil(
          context, loginScreen.idScreen, (route) => false);
    } else {
      Navigator.pop(context);
      Toast.show("New user account hasn't been created.", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }
}
