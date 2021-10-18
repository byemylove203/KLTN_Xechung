import 'dart:typed_data';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customButton.dart';
import 'package:xechung/widget/customButton2.dart';

class searchScreen extends StatefulWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  String seatController = '1 ghế ngồi';
  var addressController = TextEditingController();
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  List<String> seats = [
    '1 ghế ngồi',
    '2 ghế ngồi',
    '3 ghế ngồi',
    '4 ghế ngồi',
  ];
  TimeOfDay _startTime = TimeOfDay.now().replacing(minute: 30);
  bool choosen = false;
  // @override
  // void initState() {
  //   googlePlace = GooglePlace('AIzaSyAKPveAbIHRL4sIAmEGgvnUQ1Q3C5zluko');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
              height: 450,
              decoration: BoxDecoration(
                  color: Constants.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  )),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.fiber_manual_record,
                        //     color: Colors.grey, size: 12),
                        // Icon(Icons.fiber_manual_record,
                        //     color: Colors.grey, size: 12),
                        // Icon(Icons.fiber_manual_record,
                        //     color: Colors.grey, size: 12),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10),
                        //   child: Icon(
                        //     Icons.location_on,
                        //     color: Colors.red,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trip_origin,
                            color: Colors.blue,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
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
                                    child:
                                        Center(child: Text("Chọn điểm xuống")),
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
                                onTap: () {
                                  Navigator.of(context).push(showPicker(
                                    iosStylePicker: true,
                                    is24HrFormat: true,
                                    context: context,
                                    value: _startTime,
                                    onChange: onTimeChanged,
                                  ));
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
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                        child: Text("Chọn thời gian đón")),
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
                            Ionicons.people_outline,
                            color: Colors.white,
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
                                    child: DropdownButton(
                                      icon: SizedBox.shrink(),
                                      underline: SizedBox(),
                                      value: seatController,
                                      alignment: Alignment.center,
                                      isExpanded: true,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          seatController = newValue!;
                                        });
                                      },
                                      items: seats.map((selected) {
                                        return DropdownMenuItem(
                                          alignment: Alignment.center,
                                          value: selected,
                                          child: new Text(selected),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //cho ngoi

            Spacer(),
            customButton2("Tìm xe chung", () {})
          ],
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(
      value,
      region: "vn",
      language: "vi",
      types: "address",
    );

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _startTime = newTime;
      choosen = true;
    });
  }
}
