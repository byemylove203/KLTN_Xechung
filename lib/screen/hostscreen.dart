import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xechung/screen/addcarscreen/addcarscreen.dart';

class hostscreen extends StatefulWidget {
  const hostscreen({Key? key}) : super(key: key);

  @override
  _hostscreenState createState() => _hostscreenState();
}

class _hostscreenState extends State<hostscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Getting Stated",
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
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: addcarscreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
