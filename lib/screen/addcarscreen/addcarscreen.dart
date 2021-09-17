import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/carfeatures.dart';

import 'package:xechung/screen/addcarscreen/getcarinfo.dart';

import 'package:xechung/const/const.dart';
import 'package:xechung/widget/headertext.dart';

class addcarscreen extends StatefulWidget {
  const addcarscreen({Key? key}) : super(key: key);

  @override
  _addcarscreenState createState() => _addcarscreenState();
}

class _addcarscreenState extends State<addcarscreen> {
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Ionicons.close_circle_outline),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 795,
            child: Column(
              children: <Widget>[
                headerText(
                  "Thông tin của xe",
                  FontWeight.bold,
                  size: 30,
                ),
                SizedBox(
                  height: 16,
                ),
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
                    maxLines: 2,
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
                        labelText: "Địa điểm cho thuê xe"),
                  ),
                ),
                SizedBox(
                  height: 16,
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
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DropdownButton(
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
                ),
                SizedBox(
                  height: 16,
                ),
                DropdownButton(
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
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
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
                            print(carInfo);
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
      ),
    );
  }
}
