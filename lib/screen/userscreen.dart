import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xechung/screen/login.dart';
import 'package:ionicons/ionicons.dart';

class userscreen extends StatefulWidget {
  const userscreen({Key? key}) : super(key: key);

  @override
  _userscreenState createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Account",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "About Us",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => login()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
