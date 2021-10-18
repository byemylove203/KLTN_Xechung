import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/screen/addcarscreen/addCarImage.dart';

import 'package:xechung/screen/navbar.dart';

import 'package:xechung/widget/customtext.dart';

class confirmAddNewCar extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  final Map<String, dynamic>? rides;
  const confirmAddNewCar({Key? key, this.carInfo, this.rides})
      : super(key: key);

  @override
  _confirmAddNewCarState createState() => _confirmAddNewCarState();
}

class _confirmAddNewCarState extends State<confirmAddNewCar> {
  bool _isFilled = false;
  bool _isFilled1 = false;
  final priceController = TextEditingController();
  final seatController = TextEditingController();
  int rideID = 0;
  late FixedExtentScrollController schrollController;
  final tinhthanh = Constants.tinhthanh;
  String selected = "Chọn";
  String status = "Có sẵn";
  String bienso = "00000"; //final data (need to parse)
  int seat = 0;
  int index = 0;
  @override
  void initState() {
    super.initState();
    schrollController = FixedExtentScrollController(initialItem: index);
  }

  // @override
  // void dispose() {
  //   schrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Ionicons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: Column(
            children: [
              customText(
                "Đặt giá đi chung",
                FontWeight.bold,
                size: 30,
              ),
              customText(
                "Điền thông tin giá đi chung. Giá này là giá mỗi chỗ trên xe của bạn.",
                FontWeight.normal,
                size: 16,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 70,
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  cursorColor: Color(0xff56c596),
                  decoration: new InputDecoration(
                      prefixText: "vnđ ",
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
                      hintText: "Giá xe"),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _isFilled = true;
                      bienso = priceController.text;
                    } else
                      _isFilled = false;

                    //print(bienso);
                  },
                ),
              ),
              customText("Số lượng ghế", FontWeight.bold),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 70,
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: seatController,
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
                      hintText: "Số ghế có sẵn"),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _isFilled1 = true;
                      seat = int.tryParse(seatController.text)!;
                    } else
                      _isFilled1 = false;

                    //print(bienso);
                  },
                ),
              ),
              // Row(
              //   children: [
              //     customText(
              //       "Tỉnh/ Thành phố",
              //       FontWeight.normal,
              //       size: 16,
              //     ),
              //     Spacer(
              //       flex: 3,
              //     ),
              //     TextButton(
              //         onPressed: () {
              //           //    schrollController.dispose();
              //           schrollController =
              //               FixedExtentScrollController(initialItem: index);
              //           showCupertinoModalPopup(
              //               context: context,
              //               builder: (context) => CupertinoActionSheet(
              //                     actions: [buildPicker()],
              //                     cancelButton: CupertinoActionSheetAction(
              //                         child: Text("Xong"),
              //                         onPressed: () => Navigator.pop(context)),
              //                   ));
              //         },
              //         child: Text(
              //           selected,
              //           style: TextStyle(fontSize: 16, color: Colors.black),
              //         ))
              //   ],
              // ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                    ),
                    onPressed: () {
                      if (_isFilled == true && _isFilled1 == true) {
                        FirebaseFirestore.instance
                            .collection("Rides")
                            .get()
                            .then((querySnapshot) {
                          querySnapshot.docs.forEach((result) {
                            rideID = max(rideID, result.data()['Rides ID']);
                            // print(rideID);
                          });

                          rideID = rideID + 1;

                          final _auth = FirebaseAuth.instance;
                          final User? user = _auth.currentUser;
                          final phoneNumber = user!.phoneNumber;
                          final uid = user.uid;
                          Map<String, dynamic> rides = {
                            ...widget.rides!,
                            ...{
                              "Rides ID": rideID,
                              "Seat": seat,
                              "Price": int.tryParse(priceController.text),
                              "Driver": phoneNumber,
                              "Driver UID": uid,
                            }
                          };

                          CollectionReference newRide =
                              FirebaseFirestore.instance.collection("Rides");
                          newRide.doc((rideID).toString()).set(rides);
                        });

                        //newRide.add(rides);

                        // Map<String, dynamic> result = {
                        //   ...widget.rides!,
                        //   ...{
                        //     "License Plate": priceController.text,
                        //     "Tinh Thanh": selected,
                        //     "User": uid,
                        //     "Status": status
                        //   }
                        // };

                        //car.doc(carId.toString()).set(result);

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => addCarImage(
                        //               carInfo: rides,
                        //             )));

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => navbar()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildPicker() => SizedBox(
        height: 250,
        child: CupertinoPicker(
            scrollController: schrollController,
            itemExtent: 50,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: CupertinoColors.activeBlue.withOpacity(0.2),
            ),
            onSelectedItemChanged: (index) {
              setState(() => this.index = index);
              selected = tinhthanh[index];
            },
            children: tinhthanh
                .map((item) => Center(
                      child: Text(item),
                    ))
                .toList()),
      );
}
