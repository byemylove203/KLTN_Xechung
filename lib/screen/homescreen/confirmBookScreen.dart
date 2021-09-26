import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';

import '../navbar.dart';

class confirmHireScreen extends StatefulWidget {
  final Car? car;
  const confirmHireScreen({Key? key, this.car}) : super(key: key);

  @override
  _confirmHireScreenState createState() => _confirmHireScreenState();
}

class _confirmHireScreenState extends State<confirmHireScreen> {
  String price = "";
  String duration = "";

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
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextButton(
            child: Text(
              "XÁC NHẬN THUÊ XE",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
            ),
            onPressed: addNewHire,
          ),
        ),
      ),
    );
  }

  Future<void> addNewHire() async {
    String startDate = "";
    String endDate = "";
    String startHour = "";
    String endHour = "";
    int carId = widget.car!.carID;
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.phoneNumber;
    CollectionReference carStatus =
        FirebaseFirestore.instance.collection('carInfo');
    CollectionReference bookingOrder =
        FirebaseFirestore.instance.collection('bookingOrder');

    carStatus.doc(carId.toString()).update({'Status': 'Đã thuê'});

    // docs.forEach((element) {
    //   print(element["Status"]);
    // });
    final orderID = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, dynamic> order = {
      "Price": "200k",
      "Hire Duration": "1 ngày",
      "Client User ID": uid,
      "Host User ID": uid,
      "CarID": carId,
      "Start Date": startDate,
      "End Date": endDate,
      "Start Hour": startHour,
      "End Hour": endHour,
      "OrderID": orderID,
    };
    bookingOrder.doc(carId.toString()).set(order);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => navbar()),
      (Route<dynamic> route) => false,
    );
  }
}
