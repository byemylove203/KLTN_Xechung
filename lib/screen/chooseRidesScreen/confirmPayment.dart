import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/model/bookedOders.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/model/status.dart';
import 'package:xechung/screen/chooseRidesScreen/choosePaymentMethod.dart';
import 'package:xechung/widget/customButton2.dart';
import 'package:xechung/widget/customtext.dart';

import '../navbar.dart';

class confirmPayments extends StatefulWidget {
  final Rides rides;
  final int totalPrice;
  final int totalSeat;
  const confirmPayments(
      {Key? key,
      required this.rides,
      required this.totalPrice,
      required this.totalSeat})
      : super(key: key);

  @override
  _confirmPaymentsState createState() => _confirmPaymentsState();
}

class _confirmPaymentsState extends State<confirmPayments> {
  int orderID = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            customText("Payment Screen", FontWeight.bold),
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                child: Text("Chọn phương thức thanh toán"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => choosePaymentMethod()));
                },
              ),
            ),
            Spacer(),
            customButton2("Xác nhận đặt", addNewHire)
          ],
        ),
      ),
    );
  }

  Future<void> addNewHire() async {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final userPhoneNumber = user!.phoneNumber;
    final uid = user.uid;

    CollectionReference bookingOrder =
        FirebaseFirestore.instance.collection('bookingOrder');
    FirebaseFirestore.instance
        .collection("bookingOrder")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        orderID = max(orderID, result.data()['Order ID']);
        // print(rideID);
      });

      orderID = orderID + 1;

      BookedOrders orders = BookedOrders(
          orderID: orderID,
          clientUserID: userPhoneNumber!,
          clientUID: uid,
          driverUID: widget.rides.driverUID,
          driverID: widget.rides.userName,
          bookedSeat: widget.totalSeat,
          bookedDate: DateTime.now(),
          bookedHour: DateTime.now(),
          pickupHour: widget.rides.startHour,
          pickupLocation: widget.rides.startLocation,
          dropLocation: widget.rides.endLocation,
          price: widget.totalPrice,
          paymentMethod: "When Done",
          status: "Đang chờ xác nhận");
      Map<String, dynamic> order = {
        "Booked Date": orders.bookedDate, // cần sửa
        "Pickup Location": orders.pickupLocation,
        "Drop Location": orders.dropLocation,
        "Booked Hour": orders.bookedHour,
        "Booked Seat": orders.bookedSeat,
        "Client User ID": orders.clientUserID,
        "Driver ID": orders.driverID,
        "Order ID": orders.orderID,
        "Client UID": orders.clientUID,
        "Driver UID": orders.driverUID,
        "Payment Method": orders.paymentMethod,
        "Pickup Hour": orders.pickupHour,
        "Price": orders.price,
        "Status": orders.status,
      };
      CollectionReference newOrder =
          FirebaseFirestore.instance.collection("bookingOrder");
      newOrder.doc((orderID).toString()).set(order);
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => navbar()),
      (Route<dynamic> route) => false,
    );
  }
}
