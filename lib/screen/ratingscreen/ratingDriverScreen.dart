import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/misc/rating.dart';
import 'package:xechung/model/ratesystem.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/screen/addcarscreen/description.dart';
import 'package:xechung/widget/customButton2.dart';
import 'package:uuid/uuid.dart';

class RatingDriverScreen extends StatefulWidget {
  final Rides rides;
  const RatingDriverScreen({Key? key, required this.rides}) : super(key: key);

  @override
  _RatingDriverScreenState createState() => _RatingDriverScreenState();
}

class _RatingDriverScreenState extends State<RatingDriverScreen> {
  bool _isFilled = false;
  var uuid = Uuid();
  int rating = 0;
  final descriptionController = TextEditingController();
  String enteredText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Đánh giá",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(widget.rides.imageURL),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Chuyến đi của bạn thế nào",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Giúp chúng tôi cải thiện trải nghiệm của bạn bằng cách đánh giá chuyến đi này.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Rating(
                size: 40,
                initialRating: rating,
                onRated: (int value) {
                  setState(() {
                    _isFilled = true;
                    rating = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                child: TextFormField(
                  maxLength: 50,
                  controller: descriptionController,
                  maxLines: 10,
                  cursorColor: Color(0xff56c596),
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Color(0xff56c596),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText:
                          "Hãy chia sẻ những điều bạn thích về chuyến đi này nhé."),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextButton(
                  child: Text(
                    "XÁC NHẬN",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: _isFilled
                        ? MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor: _isFilled
                        ? MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor)
                        : MaterialStateProperty.all<Color>(Colors.black),
                    // shape: MaterialStateProperty.all<
                    //         RoundedRectangleBorder>(
                    //     RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(18.0),
                    //         side: BorderSide(
                    //             color: _isFilled
                    //                 ? Constants.kPrimaryColor
                    //                 : Colors.black)))
                  ),
                  onPressed: () {
                    final _auth = FirebaseAuth.instance;
                    final User? user = _auth.currentUser;
                    final uid = user!.uid;
                    String rateID = uuid.v1().toString();
                    RatingSystem newRating = RatingSystem(
                        dateRated: DateTime.now(),
                        driverUID: widget.rides.driverUID,
                        rateID: rateID,
                        userUID: uid,
                        rate: rating.toDouble(),
                        comment: descriptionController.text);
                    Map<String, dynamic> rate = {
                      "Rate ID": newRating.rateID,
                      "User UID": newRating.userUID,
                      "Rate": newRating.rate,
                      "Comment": newRating.comment,
                      "Driver UID": newRating.driverUID,
                      "Date Rated": newRating.dateRated
                    };

                    CollectionReference newRate =
                        FirebaseFirestore.instance.collection("rate");
                    newRate.add(rate);
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
