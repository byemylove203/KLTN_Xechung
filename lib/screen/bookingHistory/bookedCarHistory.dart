import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xechung/model/bookedOders.dart';

import 'package:xechung/widget/bookedCarWidget.dart';

class bookedCarHistory extends StatefulWidget {
  const bookedCarHistory({Key? key}) : super(key: key);

  @override
  _bookedCarHistoryState createState() => _bookedCarHistoryState();
}

class _bookedCarHistoryState extends State<bookedCarHistory> {
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
                .collection('bookingOrder')
                .where('Client User ID', isEqualTo: uid.toString())
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            return bookedCarWidget(
                                orders: bookedOrders(
                                    document['OrderID'],
                                    document['CarID'],
                                    document['Client User ID'],
                                    document['Hire Duration'],
                                    document['Price']));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

// Car(
//                                     document['Type'],
//                                     [
//                                       "assets/images/car.jpeg",
//                                       "assets/images/car_1.jpeg"
//                                     ],
//                                     document['Odormeter'],
//                                     document['Description'],
//                                     document['Features'],
//                                     document['Car ID'],
//                                     document['Status'],
//                                     true,
//                                     true)
