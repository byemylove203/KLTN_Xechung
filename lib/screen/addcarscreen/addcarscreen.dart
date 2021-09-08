import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/gatheringinfo.dart';
import 'package:vin_decoder/vin_decoder.dart';
import 'package:xechung/screen/addcarscreen/getcarinfo.dart';

class addcarscreen extends StatefulWidget {
  const addcarscreen({Key? key}) : super(key: key);

  @override
  _addcarscreenState createState() => _addcarscreenState();
}

Map? data;

class _addcarscreenState extends State<addcarscreen> {
  final addressController = TextEditingController();
  final cartypeController = TextEditingController();
  final odorController = TextEditingController();
  final transmisstionController = TextEditingController();
  final trimController = TextEditingController();
  final styleController = TextEditingController();
  bool _isFilled = false;
  addData() {
    Map<String, dynamic> Data = {
      "Address": addressController.text,
      "Type": cartypeController.text,
      "Odormeter": odorController.text,
      "Transmission": transmisstionController.text,
      "Trim": trimController.text,
      "Style": styleController.text,
    };
    CollectionReference car = FirebaseFirestore.instance.collection('carInfo');
    car.add(Data);
  }

  bool checkTextFieldEmptyOrNot() {
    String text1, text2, text3, text4, text5, text6;

    text1 = addressController.text;
    text2 = cartypeController.text;
    text3 = odorController.text;
    text4 = transmisstionController.text;
    text5 = trimController.text;
    text6 = styleController.text;

    if (text1 == '' ||
        text2 == '' ||
        text3 == '' ||
        text4 == '' ||
        text5 == '' ||
        text6 == '') return false;
    return true;
  }

  fetchData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(
                height: 16,
              ),
              Text(
                "Tell us about your car",
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Where is your Car Located?',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text("Nhận diện mẫu xe của bạn"),
                  Spacer(
                    flex: 3,
                  ),
                  TextButton(
                      onPressed: () async {
                        final String result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => getcarinfo()));
                        print(result);
                      },
                      child: Text("Bắt đầu")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
                controller: odorController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Odometer',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
                controller: transmisstionController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Transmission',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
                controller: trimController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Trim',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
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
                controller: styleController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Style',
                ),
              ),
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
                        foregroundColor: _isFilled
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)))),
                    onPressed: () {
                      if (_isFilled == true) {
                        addData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => gatheringinfo()));
                      }
                    }),
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
