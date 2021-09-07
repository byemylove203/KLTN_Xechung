import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addcarscreen extends StatefulWidget {
  const addcarscreen({Key? key}) : super(key: key);

  @override
  _addcarscreenState createState() => _addcarscreenState();
}

Map? data;

class _addcarscreenState extends State<addcarscreen> {
  addData() {
    Map<String, dynamic> demoData = {"name": "Khanh", "Age": "15"};
    CollectionReference car = FirebaseFirestore.instance.collection('carInfo');
    car.add(demoData);
  }

  fetchData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "ADD",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: addData,
              ),
            ),
          ],
        ),
        // child: Text(
        //   data.toString(),
        //   textAlign: TextAlign.center,
        //   style: TextStyle(fontSize: 30),
        // ),
      ),
    );
  }
}
