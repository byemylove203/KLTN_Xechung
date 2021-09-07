import 'package:flutter/material.dart';
import 'package:xechung/screen/addcarscreen.dart';

class hostscreen extends StatefulWidget {
  const hostscreen({Key? key}) : super(key: key);

  @override
  _hostscreenState createState() => _hostscreenState();
}

class _hostscreenState extends State<hostscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Đọc Dữ Liệu",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Getting Stated",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addcarscreen()));
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Sửa Dữ Liệu",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextButton(
                child: Text(
                  "Xoá Dữ Liệu",
                  style: TextStyle(fontSize: 15.0),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {},
              ),
            ),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
