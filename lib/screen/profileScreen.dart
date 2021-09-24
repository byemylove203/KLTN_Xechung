import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/screen/login.dart';
import '../widget/customButton.dart';
import 'addcarscreen/hostedcarscreen/addCarImage.dart';

class userscreen extends StatefulWidget {
  const userscreen({Key? key}) : super(key: key);

  @override
  _userscreenState createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  final _auth = FirebaseAuth.instance;

  void inputData() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => addCarImage()));
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.phoneNumber;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                boxShadow: kElevationToShadow[1],
                color: Theme.of(context).bottomAppBarColor,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 28, top: 30),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/images/user_1.jpeg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28, top: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            uid!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 17,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Hà Nội",
                                    style: TextStyle(
                                        wordSpacing: 1, letterSpacing: 3),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
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
              color: Colors.red.shade400,
              text: "Đăng Xuất",
              icon: Icon(
                Ionicons.log_out_outline,
                color: Colors.red.shade400,
              ),
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
