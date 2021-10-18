import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:page_transition/page_transition.dart';
import 'package:xechung/screen/addcarscreen/addcarscreen.dart';
import 'package:xechung/screen/hostedcarscreen/driverRequestScreen.dart';
import 'package:xechung/widget/customButton.dart';

class hostscreen extends StatefulWidget {
  const hostscreen({Key? key}) : super(key: key);

  @override
  _hostscreenState createState() => _hostscreenState();
}

class _hostscreenState extends State<hostscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            customButton(
              text: "Đăng lộ trình của bạn",
              icon: Icon(Ionicons.play_outline),
              press: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        type: PageTransitionType.size,
                        duration: Duration(milliseconds: 250),
                        reverseDuration: Duration(milliseconds: 250),
                        child: addcarscreen()))
              },
            ),
            customButton(
              text: "Yêu cầu đi chung",
              icon: Icon(Ionicons.car_outline),
              press: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        type: PageTransitionType.size,
                        duration: Duration(milliseconds: 300),
                        reverseDuration: Duration(milliseconds: 300),
                        child: DriverRequestScreen()))
              },
            ),
            // Container(
            //   margin: EdgeInsets.all(15),
            //   child: TextButton(
            //     child: Text(
            //       "Getting Stated",
            //       style: TextStyle(fontSize: 15.0),
            //     ),
            //     style: ButtonStyle(
            //         padding: MaterialStateProperty.all<EdgeInsets>(
            //             EdgeInsets.all(15)),
            //         foregroundColor:
            //             MaterialStateProperty.all<Color>(Colors.black),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //             RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(18.0),
            //                 side: BorderSide(color: Colors.black)))),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               alignment: Alignment.bottomCenter,
            //               type: PageTransitionType.size,
            //               duration: Duration(milliseconds: 300),
            //               reverseDuration: Duration(milliseconds: 300),
            //               child: addcarscreen()));
            //     },
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}


//// Nút cũ
// Container(
            //   margin: EdgeInsets.all(15),
            //   child: TextButton(
            //     child: Text(
            //       "Getting Stated",
            //       style: TextStyle(fontSize: 15.0),
            //     ),
            //     style: ButtonStyle(
            //         padding: MaterialStateProperty.all<EdgeInsets>(
            //             EdgeInsets.all(15)),
            //         foregroundColor:
            //             MaterialStateProperty.all<Color>(Colors.black),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //             RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(18.0),
            //                 side: BorderSide(color: Colors.black)))),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.bottomToTop,
            //               duration: Duration(milliseconds: 300),
            //               reverseDuration: Duration(milliseconds: 300),
            //               child: addcarscreen()));
            //     },
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.all(15),
            //   child: TextButton(
            //     child: Text(
            //       "Xe của bạn",
            //       style: TextStyle(fontSize: 15.0),
            //     ),
            //     style: ButtonStyle(
            //         padding: MaterialStateProperty.all<EdgeInsets>(
            //             EdgeInsets.all(15)),
            //         foregroundColor:
            //             MaterialStateProperty.all<Color>(Colors.black),
            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //             RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(18.0),
            //                 side: BorderSide(color: Colors.black)))),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           PageTransition(
            //               type: PageTransitionType.bottomToTop,
            //               duration: Duration(milliseconds: 300),
            //               reverseDuration: Duration(milliseconds: 300),
            //               child: hostedCar()));
            //     },
            //   ),
            // ),