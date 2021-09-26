import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xechung/const/const.dart';

class customButton2 extends StatelessWidget {
  final String text;
  final VoidCallback? press;

  customButton2(
    this.text,
    this.press,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextButton(
            child: Text(
              text,
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Constants.kPrimaryColor),
            ),
            onPressed: press),
      ),
    );
  }
}
