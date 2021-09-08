//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:xechung/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/screen/homescreen.dart';
import 'package:xechung/screen/hostscreen.dart';
import 'package:xechung/screen/messagescreen.dart';
import 'package:xechung/screen/searchscreen.dart';
import 'package:xechung/screen/userscreen.dart';

class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  //final _auth = FirebaseAuth.instance;

  int _seletedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homescreen(),
    searchscreen(),
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
        selectedColor: Colors.white,
        unSelectedColor: Color(0xffacacac),
        backgroundColor: Colors.black,
        items: [
          CustomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
//            title: Text("Trang chủ"),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.search_outline),
//            title: Text("Search"),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.chatbox_ellipses_outline),
//            title: Text("Tin nhắn"),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.car_outline),
//            title: Text("Host"),
          ),
          CustomNavigationBarItem(
            icon: Icon(Ionicons.person_circle_outline),
//            title: Text("Tài Khoản"),
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
