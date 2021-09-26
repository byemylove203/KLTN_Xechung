import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/screen/homescreen/carDetail.dart';

import '../navbar.dart';

class editcarScreen extends StatelessWidget {
  final Car car;

  const editcarScreen({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(car.status);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                      child: Text(
                        "XOÁ XE NÀY",
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("carInfo")
                            .doc(car.carID.toString())
                            .update({"User": "None"});
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => navbar()),
                          (Route<dynamic> route) => false,
                        );
                      })),
            ],
          ),
        ));
  }
}
