import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/screen/login.dart';
import 'profile_menu.dart';

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
            SizedBox(height: 100),
            ProfileMenu(
              text: "Tài Khoản",
              icon: Icon(Ionicons.person_outline),
              press: () => {},
            ),
            ProfileMenu(
              text: "Về Chúng Tôi",
              icon: Icon(Ionicons.people_outline),
              press: () => {},
            ),
            ProfileMenu(
              text: "Đăng Xuất",
              icon: Icon(Ionicons.log_out_outline),
              press: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => login()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
