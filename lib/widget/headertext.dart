import 'package:flutter/material.dart';

class headerText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  headerText(this.text, this.fontWeight,
      {this.color = Colors.black, this.size = 23});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
      child: Align(
        child: Text(
          text,
          style:
              TextStyle(fontSize: size, fontWeight: fontWeight, color: color),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
