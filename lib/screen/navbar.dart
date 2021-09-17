//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:xechung/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/screen/homescreen/homescreen.dart';
import 'package:xechung/screen/hostscreen.dart';
import 'package:xechung/screen/messagescreen.dart';
import 'package:xechung/screen/bookingHistory/bookedCarHistory.dart';
import 'package:xechung/screen/userscreen.dart';
import 'package:xechung/widget/headertext.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  //final _auth = FirebaseAuth.instance;
//Defaut Screen, change this to set default screen!!!!!
  int _seletedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homescreen(),
    bookedCarHistory(),
    messagescreen(),
    hostscreen(),
    userscreen(),
  ];

  Widget _buildTitle() {
    void _onItemTap(int index) {
      setState(() {
        _seletedIndex = index;
      });
    }

    return CustomNavigationBar(
        iconSize: 25.0,
        strokeColor: Colors.white,
        selectedColor: Color(0xff7BE495),
        unSelectedColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(
            icon: Icon(Ionicons.home),
            title: headerText(
              "Trang Chủ",
              FontWeight.normal,
              size: 10,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.calendar_outline),
            title: headerText(
              "Lịch sử",
              FontWeight.normal,
              size: 10,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.chatbox_ellipses),
            title: headerText(
              "Tin nhắn",
              FontWeight.normal,
              size: 10,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.car),
            title: headerText(
              "Chủ xe",
              FontWeight.normal,
              size: 10,
            ),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.person_circle),
            title: headerText(
              "Tài khoản",
              FontWeight.normal,
              size: 10,
            ),
          ),
        ],
        currentIndex: _seletedIndex,
        onTap: _onItemTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Xe Chung"),
      //   backgroundColor: Colors.black,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_seletedIndex),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () async {
      //     await _auth.signOut();
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => login()));
      //   },
      //   child: Icon(Ionicons.log_out_outline),
      // ),
      bottomNavigationBar: _buildTitle(),
    );
  }
}
