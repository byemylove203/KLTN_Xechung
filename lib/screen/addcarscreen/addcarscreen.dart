import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/carfeatures.dart';

import 'package:xechung/screen/addcarscreen/getcarinfo.dart';

import 'package:xechung/const/const.dart';

class addcarscreen extends StatefulWidget {
  const addcarscreen({Key? key}) : super(key: key);

  @override
  _addcarscreenState createState() => _addcarscreenState();
}

class _addcarscreenState extends State<addcarscreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
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

  bool _isFilled = false;
  String carType = "";
  String text = "Nhận diện xe của bạn";
  List<String> odor = [
    '0-10 vạn km',
    '10-20 vạn km',
    '20-30 vạn km',
    '30-40 vạn km',
    '40-50 vạn km'
  ];
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
        body: Container(
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
                          onTap: () {},
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Center(child: Text("Chọn điểm đón")),
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
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: InkWell(
                              onTap: () {},
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
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Center(child: Text("Chọn điểm xuống")),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        onChanged: (value) {
                          if (value.length > 0 && checkTextFieldEmptyOrNot()) {
                            setState(() {
                              _isFilled = true;
                            });
                          } else {
                            setState(() {
                              _isFilled = false;
                            });
                          }
                        },
                        controller: addressController,
                        maxLines: 1,
                        cursorColor: Color(0xff56c596),
                        decoration: new InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Địa điểm cho thuê xe"),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 10),
                            child: Text(
                              text,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              final String result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => getcarinfo()));
                              setState(() {
                                carType = result;
                                text = "Mẫu xe của bạn là: " + carType;
                                cartypeController.text = carType;
                              });
                            },
                            child: Text("Bắt đầu")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Odor"),
                        DropdownButton(
                          value: odorController,
                          onChanged: (String? newValue) {
                            setState(() {
                              odorController = newValue!;
                            });
                          },
                          items: odor.map((selected) {
                            return DropdownMenuItem(
                              value: selected,
                              child: new Text(selected),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hộp số"),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: DropdownButton(
                          value: transmisstionController,
                          onChanged: (String? newValue) {
                            setState(() {
                              transmisstionController = newValue!;
                            });
                          },
                          items: transmissions.map((selected) {
                            return DropdownMenuItem(
                              value: selected,
                              child: new Text(selected),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
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
    );
  }
}
