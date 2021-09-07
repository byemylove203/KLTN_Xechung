import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xechung/screen/login.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  Widget _buildTitle() {
    void _onItemTap(int index) {
      setState(() {
        _currentIndex = index;
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
        currentIndex: _currentIndex,
        onTap: _onItemTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "USER LOGGED IN",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => login()));
        },
        child: Icon(Ionicons.log_out_outline),
      ),
      bottomNavigationBar: _buildTitle(),
    );
  }
}
