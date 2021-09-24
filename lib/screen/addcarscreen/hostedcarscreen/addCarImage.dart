import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path/path.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customButton.dart';

class addCarImage extends StatefulWidget {
  const addCarImage({Key? key}) : super(key: key);

  @override
  _addCarImageState createState() => _addCarImageState();
}

class _addCarImageState extends State<addCarImage> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : "No File Selected";
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
              text: fileName,
              icon: Icon(Ionicons.push_outline),
              press: selectImage),
        ],
      ),
    );
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;

    final path = result.files.single.path!;
    setState(() => file = File(path));
  }
}
