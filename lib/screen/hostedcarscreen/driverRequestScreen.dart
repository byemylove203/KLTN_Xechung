import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/bookedOders.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/screen/messagescreen/MessageScreen.dart';

import 'package:xechung/widget/DriverRequestWidget.dart';
import 'package:xechung/widget/RideRequestCardWidget.dart';
import 'package:xechung/widget/rideHistoryCardWidget.dart';

class DriverRequestScreen extends StatefulWidget {
  const DriverRequestScreen({Key? key}) : super(key: key);

  @override
  State<DriverRequestScreen> createState() => _DriverRequestScreenState();
}

class _DriverRequestScreenState extends State<DriverRequestScreen> {
  final double expandedHeight = 400;
  // Rides rides = Rides(["Thứ 2"], DateTime.now());

  //List<Car> cars = getCarList();
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.phoneNumber;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageScreen()));
                },
                icon: Icon(Ionicons.chatbubble_ellipses_outline),
                color: Colors.black,
              )
            ],
            leading: IconButton(
              icon: Icon(Ionicons.close_circle_outline),
              color: Colors.black,
              onPressed: () => Navigator.pop(context, false),
            ),
            centerTitle: true,
            title: Text(
              "Yêu cầu đi chung",
              style: TextStyle(color: Colors.black),
            ),
            toolbarHeight: Constants.AppBarHeight,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bookingOrder')
                  .where('Driver ID', isEqualTo: uid.toString())
                  .orderBy('Order ID', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  child: Column(children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 4,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Container(
                    //       color: Constants.kPrimaryColor,
                    //       child: Text(
                    //         "SEARCH",
                    //       )),
                    // ),

                    Container(
                      // padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height - 200,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: snapshot.data!.docs.map((document) {
                          Rides rides = Rides(
                            ["Thứ 2", "Thứ 3"],
                            document['Pickup Hour'].toDate(),
                            userName: document['Driver ID'],
                          );
                          //ktra xem status xe chua bi thue thi hien len task 17/9
                          return RideRequestCardWidget(
                            rides: rides,
                            bookedOrders: BookedOrders(
                                bookedDate: document['Booked Date'].toDate(),
                                bookedHour: document['Booked Hour'].toDate(),
                                bookedSeat: document['Booked Seat'],
                                clientUserID: document['Client User ID'],
                                driverID: document['Driver ID'],
                                dropLocation: document['Drop Location'],
                                orderID: document['Order ID'],
                                clientUID: document['Client UID'],
                                driverUID: document['Driver UID'],
                                paymentMethod: document['Payment Method'],
                                pickupHour: document['Pickup Hour'].toDate(),
                                pickupLocation: document['Pickup Location'],
                                price: document['Price'],
                                status: document['Status']),
                          );
                        }).toList(),
                      ),
                    ),
                  ]),
                );
              }),
        ));
  }
}
