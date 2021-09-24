import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xechung/model/car.dart';

import 'package:xechung/widget/hostedCarWidget.dart';

class hostedCar extends StatelessWidget {
  const hostedCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('carInfo')
            .where('User', isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      children: snapshot.data!.docs.map((document) {
                        // print(document.data);
                        return hostedCarwidget(
                            car: Car(
                                document['Type'],
                                [
                                  "assets/images/car.jpeg",
                                  "assets/images/car_1.jpeg"
                                ],
                                "200k",
                                document['Description'],
                                document['Features'],
                                document['Car ID'],
                                document['User'],
                                document['Status'],
                                true,
                                true));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
