import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/screen/login.dart';
import '../widget/customButton.dart';

class userscreen extends StatefulWidget {
  const userscreen({Key? key}) : super(key: key);

  @override
  _userscreenState createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  final _auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = _auth.currentUser;
    final uid = user!.phoneNumber;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            customButton(
              text: "Tài Khoản",
              icon: Icon(Ionicons.person_outline),
              press: () => {},
            ),
            customButton(
              text: "Về Chúng Tôi",
              icon: Icon(Ionicons.people_outline),
              press: inputData,
            ),
            customButton(
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
