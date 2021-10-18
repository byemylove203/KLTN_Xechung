import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/carfeatures.dart';

import 'package:day_night_time_picker/day_night_time_picker.dart';

import 'package:xechung/const/const.dart';
import 'package:xechung/screen/addcarscreen/searchforendpoint.dart';
import 'package:xechung/screen/addcarscreen/searchforstartpoint.dart';

import 'package:xechung/widget/customtext.dart';

class addcarscreen extends StatefulWidget {
  const addcarscreen({Key? key}) : super(key: key);

  @override
  _addcarscreenState createState() => _addcarscreenState();
}

class _addcarscreenState extends State<addcarscreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.027763, 105.834160),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final addressController = TextEditingController();
  final cartypeController = TextEditingController();
  String odorController = "0-10 vạn km";
  String transmisstionController = "Số tự động";
  bool choosen = false;
  bool pickedStartPoint = false;
  bool pickedEndPoint = false;
  bool _isFilled = false;
  String carType = "";
  String startPoint = "Chọn điểm bắt đầu";
  String endPoint = "Chọn điểm cuối";

  String text = "Nhận diện xe của bạn";
  List<String> odor = [
    '0-10 vạn km',
    '10-20 vạn km',
    '20-30 vạn km',
    '30-40 vạn km',
    '40-50 vạn km'
  ];
  DateTime startTime = DateTime.now();
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  //List<bool> days = [true, true, true, true, true, true, true];
  List<String> transmissions = [
    'Số tự động',
    'Số sàn',
  ];

  bool checkTextFieldEmptyOrNot() {
    String text1, text2, text3, text4;

    text1 = addressController.text;
    text2 = cartypeController.text;
    text3 = odorController;
    text4 = transmisstionController;

    if (text1 == '' || text2 == '' || text3 == '' || text4 == '') return false;
    return true;
  }

  TimeOfDay _startTime = TimeOfDay.now().replacing(minute: 30);
  fetchData() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Ionicons.close_circle_outline),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            //height: 795,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Constants.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      )),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.trip_origin,
                            color: Colors.blue,
                          ),
                          InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        searchForStartPoint()),
                              );
                              result != null
                                  ? setState(() {
                                      startPoint = result;
                                      pickedStartPoint = true;
                                      print(result);
                                    })
                                  : {};
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(startPoint),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: InkWell(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                              apiKey: Constants.apiKey,
                                              onPlacePicked: (result) {
                                                print(result.name);
                                                Navigator.of(context).pop();
                                              },
                                              initialPosition:
                                                  LatLng(21.027763, 105.834160),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _controller
                                                    .complete(controller);
                                              },
                                              useCurrentLocation: true,
                                              autocompleteLanguage: "vi",
                                              autocompleteTypes: ["address"],
                                              strictbounds: true,
                                              region: "vn",
                                              searchingText: "Đang tìm...",
                                              hintText: "Tìm điểm đón",
                                            )),
                                  );
                                  result != null
                                      ? setState(() {
                                          endPoint = result;
                                          pickedEndPoint = true;
                                          print(result);
                                        })
                                      : {};
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(child: Text(endPoint)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Ionicons.time_outline,
                            color: Colors.white,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      iosStylePicker: true,
                                      is24HrFormat: true,
                                      context: context,
                                      value: _startTime,
                                      onChange: onTimeChanged,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                        child: choosen
                                            ? Text(_startTime.hour.toString() +
                                                ":" +
                                                _startTime.minute.toString())
                                            : Text("Thời gian bắt đầu đi")),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Ionicons.calendar_outline,
                      //       color: Colors.white,
                      //     ),
                      //     Container(
                      //       margin: EdgeInsets.only(
                      //         left: 10,
                      //         top: 10,
                      //         bottom: 10,
                      //       ),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: Colors.white),
                      //       child: SizedBox(
                      //         height: 40,
                      //         width: MediaQuery.of(context).size.width * 0.8,
                      //         child: InkWell(
                      //           onTap: () async {
                      //             final result = await Navigator.push(
                      //               context,
                      //               PageRouteBuilder(
                      //                   barrierDismissible: true,
                      //                   opaque: false,
                      //                   pageBuilder: (_, anim1, anim2) =>
                      //                       SlideTransition(
                      //                         position: Tween<Offset>(
                      //                                 begin: Offset(0.0, 1.0),
                      //                                 end: Offset.zero)
                      //                             .animate(anim1),
                      //                         child: calendarPopUp(),
                      //                       )),
                      //             );
                      //             setState(() {});
                      //           },
                      //           child: Container(
                      //             margin: EdgeInsets.only(
                      //               left: 10,
                      //               top: 10,
                      //               bottom: 10,
                      //             ),
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(50),
                      //                 color: Colors.white),
                      //             child: SizedBox(
                      //               height: 40,
                      //               width:
                      //                   MediaQuery.of(context).size.width * 0.8,
                      //               child: Center(child: Text("Ngày đi")),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   child: TextFormField(
                      //     onChanged: (value) {
                      //       if (value.length > 0 && checkTextFieldEmptyOrNot()) {
                      //         setState(() {
                      //           _isFilled = true;
                      //         });
                      //       } else {
                      //         setState(() {
                      //           _isFilled = false;
                      //         });
                      //       }
                      //     },
                      //     controller: addressController,
                      //     maxLines: 1,
                      //     cursorColor: Color(0xff56c596),
                      //     decoration: new InputDecoration(
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(25.0),
                      //           borderSide: BorderSide(
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //         contentPadding: EdgeInsets.only(
                      //             left: 15, bottom: 11, top: 11, right: 15),
                      //         hintText: "Địa điểm cho thuê xe"),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 32,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(
                      //             left: 20, right: 10, top: 10, bottom: 10),
                      //         child: Text(
                      //           text,
                      //           maxLines: 3,
                      //           overflow: TextOverflow.ellipsis,
                      //           softWrap: false,
                      //           style: TextStyle(fontSize: 16),
                      //         ),
                      //       ),
                      //     ),
                      //     TextButton(
                      //         onPressed: () async {
                      //           final String result = await Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => getcarinfo()));
                      //           setState(() {
                      //             carType = result;
                      //             text = "Mẫu xe của bạn là: " + carType;
                      //             cartypeController.text = carType;
                      //           });
                      //         },
                      //         child: Text("Bắt đầu")),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 25,
                // ),
                // customText("Đặt giá", FontWeight.bold),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   child: TextFormField(
                //     onChanged: (value) {
                //       if (value.length > 0 && checkTextFieldEmptyOrNot()) {
                //         setState(() {
                //           _isFilled = true;
                //         });
                //       } else {
                //         setState(() {
                //           _isFilled = false;
                //         });
                //       }
                //     },
                //     controller: addressController,
                //     maxLines: 1,
                //     cursorColor: Color(0xff56c596),
                //     decoration: new InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(25.0),
                //           borderSide: BorderSide(
                //             color: Colors.black,
                //           ),
                //         ),
                //         contentPadding: EdgeInsets.only(
                //             left: 15, bottom: 11, top: 11, right: 15),
                //         hintText: "Chọn giá cuốc xe"),
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Column(
                //       children: [
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: monday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.monday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 2"),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: tuesday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.tuesday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 3"),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: wednesday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.wednesday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 4"),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: thursday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.thursday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 5"),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: friday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.friday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 6"),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: saturday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.saturday = value!;
                //                   });
                //                 }),
                //             Text("Thứ 7"),
                //           ],
                //         ),
                //         Row(
                //           children: [
                //             Checkbox(
                //                 value: sunday,
                //                 onChanged: (value) {
                //                   setState(() {
                //                     this.sunday = value!;
                //                   });
                //                 }),
                //             Text("Chủ Nhật"),
                //           ],
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                SizedBox(height: 250),
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  margin: EdgeInsets.all(15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                        child: Text(
                          "TIẾP TỤC",
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
                          if (_isFilled == true) {
                            Map<String, dynamic> rides = {
                              "Pick Up Location": startPoint,
                              "Drop Location": endPoint,
                              "Start Time": startTime,
                            };
                            print(rides);
                            Map<String, dynamic> carInfo = {
                              "Address": addressController.text,
                              "Type": cartypeController.text,
                              "Odormeter": odorController,
                              "Transmission": transmisstionController,
                            };
                            //  print(carInfo);
                            //addData();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => carFeatures(
                                          carInfo: carInfo,
                                          rides: rides,
                                        )));
                          }
                        }),
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
        ),
      ),
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _startTime = newTime;

      final now = new DateTime.now();
      startTime =
          DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
      choosen = true;
      if (pickedEndPoint && pickedStartPoint) _isFilled = true;
    });
  }
}
