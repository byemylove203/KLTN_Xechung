import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/screen/addcarscreen/hostedcarscreen/addCarImage.dart';

import 'package:xechung/screen/navbar.dart';

import 'package:xechung/widget/customtext.dart';

class confirmAddNewCar extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  const confirmAddNewCar({Key? key, this.carInfo}) : super(key: key);

  @override
  _confirmAddNewCarState createState() => _confirmAddNewCarState();
}

class _confirmAddNewCarState extends State<confirmAddNewCar> {
  final liscensePlateController = TextEditingController();
  late FixedExtentScrollController schrollController;
  final tinhthanh = Constants.tinhthanh;
  String selected = "Chọn";
  String status = "Có sẵn";
  String bienso = "00000"; //final data (need to parse)
  int index = 0;
  @override
  void initState() {
    super.initState();
    schrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    schrollController.dispose();
    super.dispose();
  }

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
                "Biển số xe",
                FontWeight.bold,
                size: 30,
              ),
              customText(
                "Điền thông tin biển số xe của bạn. Thông tin này sẽ không được công khai.",
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
                  controller: liscensePlateController,
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
                      hintText: "Biển số xe"),
                  onChanged: (value) {
                    bienso = liscensePlateController.text;
                    print(bienso);
                  },
                ),
              ),
              Row(
                children: [
                  customText(
                    "Tỉnh/ Thành phố",
                    FontWeight.normal,
                    size: 16,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  TextButton(
                      onPressed: () {
                        //    schrollController.dispose();
                        schrollController =
                            FixedExtentScrollController(initialItem: index);
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                                  actions: [buildPicker()],
                                  cancelButton: CupertinoActionSheetAction(
                                      child: Text("Xong"),
                                      onPressed: () => Navigator.pop(context)),
                                ));
                      },
                      child: Text(
                        selected,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ))
                ],
              ),
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("carInfo")
                          .get()
                          .then((querySnapshot) {
                        querySnapshot.docs.forEach((result) {
                          print(result.data()['Car ID']);
                        });
                      });
                      final carId = DateTime.now().millisecondsSinceEpoch;
                      final _auth = FirebaseAuth.instance;
                      final User? user = _auth.currentUser;
                      final uid = user!.phoneNumber;
                      Map<String, dynamic> result = {
                        ...widget.carInfo!,
                        ...{
                          "License Plate": liscensePlateController.text,
                          "Tinh Thanh": selected,
                          "User": uid,
                          "Car ID": carId.toString(),
                          "Status": status
                        }
                      };

                      CollectionReference car =
                          FirebaseFirestore.instance.collection('carInfo');
                      car.doc(carId.toString()).set(result);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addCarImage()));
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => navbar()),
                      //   (Route<dynamic> route) => false,
                      // );
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
