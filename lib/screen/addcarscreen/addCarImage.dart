import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path/path.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customButton.dart';

import '../navbar.dart';

class addCarImage extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  const addCarImage({Key? key, this.carInfo}) : super(key: key);

  @override
  _addCarImageState createState() => _addCarImageState();
}

class _addCarImageState extends State<addCarImage> {
  UploadTask? task;
  String url1 = "";
  String url2 = "";
  String url3 = "";
  String url4 = "";
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  int carId = 0;

  @override
  Widget build(BuildContext context) {
    final fileName1 =
        file1 != null ? basename(file1!.path) : "No File Selected";
    final fileName2 =
        file2 != null ? basename(file2!.path) : "No File Selected";
    final fileName3 =
        file3 != null ? basename(file3!.path) : "No File Selected";
    final fileName4 =
        file4 != null ? basename(file4!.path) : "No File Selected";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Ionicons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          customButton(
              text: fileName1,
              icon: Icon(Ionicons.push_outline),
              press: selectImage1),
          customButton(
              text: fileName2,
              icon: Icon(Ionicons.push_outline),
              press: selectImage2),
          customButton(
              text: fileName3,
              icon: Icon(Ionicons.push_outline),
              press: selectImage3),
          customButton(
              text: fileName4,
              icon: Icon(Ionicons.push_outline),
              press: selectImage4),
          customButton(
            text: "Xác nhận",
            icon: Icon(Ionicons.push_outline),
            press: () {
              uploadData();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => navbar()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          customButton(
            text: "Check",
            icon: Icon(Ionicons.push_outline),
            press: () {
              check();
            },
          )
        ],
      ),
    );
  }

  Future selectImage1() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result == null) return;

    final path = result.files.single.path!;
    setState(() => file1 = File(path));
    final fileName = basename(file1!.path);
    final destination = 'images/car/$fileName';
    var imageFile = FirebaseStorage.instance.ref().child(destination);
    task = imageFile.putFile(file1!);
    TaskSnapshot? snapshot = await task;
    url1 = await snapshot!.ref.getDownloadURL();
    //CollectionReference car = FirebaseFirestore.instance.collection("carInfo");
  }

  Future selectImage2() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result == null) return;

    final path = result.files.single.path!;
    setState(() => file2 = File(path));
    final fileName = basename(file2!.path);
    final destination = 'images/car/$fileName';
    var imageFile = FirebaseStorage.instance.ref().child(destination);
    task = imageFile.putFile(file2!);
    TaskSnapshot? snapshot = await task;
    url2 = await snapshot!.ref.getDownloadURL();
    //CollectionReference car = FirebaseFirestore.instance.collection("carInfo");
  }

  Future selectImage3() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result == null) return;

    final path = result.files.single.path!;
    setState(() => file3 = File(path));
    final fileName = basename(file3!.path);
    final destination = 'images/car/$fileName';
    var imageFile = FirebaseStorage.instance.ref().child(destination);
    task = imageFile.putFile(file3!);
    TaskSnapshot? snapshot = await task;
    url3 = await snapshot!.ref.getDownloadURL();
    //CollectionReference car = FirebaseFirestore.instance.collection("carInfo");
  }

  Future selectImage4() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result == null) return;

    final path = result.files.single.path!;
    setState(() => file4 = File(path));
    final fileName = basename(file4!.path);
    final destination = 'images/car/$fileName';
    var imageFile = FirebaseStorage.instance.ref().child(destination);
    task = imageFile.putFile(file4!);
    TaskSnapshot? snapshot = await task;
    url4 = await snapshot!.ref.getDownloadURL();
  }

  void uploadData() {
    FirebaseFirestore.instance
        .collection("carInfo")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        carId = max(carId, result.data()['Car ID']);
      });

      carId = carId + 1;
      List<String> url = [];
      if (url1 != "" && url2 != "" && url3 != "" && url4 != "") {
        url.add(url1);
        url.add(url2);
        url.add(url3);
        url.add(url4);
      }
      Map<String, dynamic> fullCarInfo = {
        ...widget.carInfo!,
        ...{"Images URL": url, "Car ID": carId}
      };

      CollectionReference car =
          FirebaseFirestore.instance.collection("carInfo");
      car.doc(carId.toString()).set(fullCarInfo);
    });
  }

  void check() async {
    FirebaseFirestore.instance
        .collection("carInfo")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        carId = max(carId, result.data()['Car ID']);
      });
      print(carId);
    });
  }
}
