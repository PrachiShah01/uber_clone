import 'package:flutter/material.dart';

class progressDialog extends StatelessWidget {
  String message;
  progressDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.amber,
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              message,
              style: TextStyle(color: Colors.black, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
