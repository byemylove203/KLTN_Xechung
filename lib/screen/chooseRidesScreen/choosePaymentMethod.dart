import 'package:flutter/material.dart';
import 'package:xechung/widget/customButton2.dart';

class choosePaymentMethod extends StatefulWidget {
  const choosePaymentMethod({Key? key}) : super(key: key);

  @override
  _choosePaymentMethodState createState() => _choosePaymentMethodState();
}

class _choosePaymentMethodState extends State<choosePaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phương thức thanh toán"),
      ),
      body: Center(
        child: Column(
          children: [
            customButton2("Đồng ý", () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }
}
