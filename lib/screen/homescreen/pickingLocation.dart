import 'package:flutter/material.dart';

import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/screen/homescreen/confirmHireScreen.dart';

class pickingLocation extends StatefulWidget {
  final Car? car;
  const pickingLocation({Key? key, this.car}) : super(key: key);

  @override
  _pickingLocationState createState() => _pickingLocationState();
}

class _pickingLocationState extends State<pickingLocation> {
  final addressController = TextEditingController();
  bool _isFilled = false;
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
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length > 0) {
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
                        labelText: "Địa điểm lấy xe"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    child: Text(
                      "TIẾP TỤC",
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => confirmHireScreen(
                                    car: widget.car,
                                  )));
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
