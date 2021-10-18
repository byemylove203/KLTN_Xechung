import 'package:flutter/material.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/widget/customButton2.dart';

class chooseSeatNumber extends StatefulWidget {
  final Rides rides;
  const chooseSeatNumber({Key? key, required this.rides}) : super(key: key);

  @override
  _chooseSeatNumberState createState() => _chooseSeatNumberState();
}

class _chooseSeatNumberState extends State<chooseSeatNumber> {
  int chossenSeat = 1;
  late int avaiableSeat = widget.rides.avaiableSeats;
  late int totalPrice = widget.rides.price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("Chọn số ghế bạn muốn đặt"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (chossenSeat > 1) {
                      setState(() {
                        totalPrice = widget.rides.price;
                        chossenSeat--;
                        totalPrice = chossenSeat * totalPrice;
                      });
                    }
                  },
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(24),
                  ),
                ),
                Text(chossenSeat.toString()),
                ElevatedButton(
                  onPressed: () {
                    if (chossenSeat <= avaiableSeat - 1) {
                      setState(() {
                        totalPrice = widget.rides.price;
                        chossenSeat++;
                        totalPrice = chossenSeat * totalPrice;
                      });
                    }
                  },
                  child: Text('+', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(24),
                  ),
                ),
              ],
            ),
            Text("Tổng giá"),
            Text(totalPrice.toString()),
            Spacer(),
            customButton2("Xác nhận", () {
              List<int> result = [];
              result.add(chossenSeat);
              result.add(totalPrice);
              Navigator.pop(context, result);
            }),
          ],
        ),
      ),
    ));
  }
}
