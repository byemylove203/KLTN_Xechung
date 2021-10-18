import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/model/status.dart';
import 'package:xechung/screen/chooseRidesScreen/chooseSeatNumber.dart';
import 'package:xechung/screen/chooseRidesScreen/chosseTravelDay.dart';
import 'package:xechung/screen/chooseRidesScreen/confirmPayment.dart';
import 'package:xechung/widget/customButton2.dart';

class rideDetail extends StatefulWidget {
  final Rides rides;

  rideDetail({required this.rides});

  @override
  State<rideDetail> createState() => _rideDetailState();
}

class _rideDetailState extends State<rideDetail> {
  List<String> choosenDay = [];
  int choosenSeat = 0;
  late int totalPrice = widget.rides.price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(widget.rides.imageURL),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(widget.rides.userName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(widget.rides.carInfo),
                          Text("Địa điểm",
                              style: TextStyle(
                                  color: Constants.kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text("Điểm đón:",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text(widget.rides.startLocation,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal)),
                          Text("Điểm xuống:",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Text(widget.rides.endLocation,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 40),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Row(
                      children: [
                        Text("Địa điểm",
                            style: TextStyle(
                                color: Constants.kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Ngày:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            InkWell(
                              onTap: () async {
                                List<String> result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => chooseTravelDate(
                                            rides: widget.rides)));
                                setState(() {
                                  choosenDay = result;
                                });
                              },
                              child: choosenDay.isEmpty
                                  ? Text("Chọn ngày đi",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.underline,
                                      ))
                                  : Text(choosenDay.join(", "),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.alarm_outlined),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Giờ bắt đầu:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                                widget.rides.startHour.hour.toString() +
                                    ":" +
                                    widget.rides.startHour.minute.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 40),
              height: MediaQuery.of(context).size.height * 0.21,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Row(
                      children: [
                        Text("Đơn giá & số ghế",
                            style: TextStyle(
                                color: Constants.kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Ionicons.card_outline),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Giá:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(totalPrice.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Ionicons.car_outline),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text("Số ghế:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            InkWell(
                              onTap: () async {
                                List<int> result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => chooseSeatNumber(
                                            rides: widget.rides)));
                                setState(() {
                                  totalPrice = result[1];
                                  choosenSeat = result[0];
                                });
                              },
                              child: choosenSeat == 0
                                  ? Text("Chọn số ghế muốn đặt",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.underline,
                                      ))
                                  : Text(choosenSeat.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            customButton2("Xác nhận đặt", () {
              if (choosenDay != [] && choosenSeat != 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => confirmPayments(
                              rides: widget.rides,
                              totalPrice: totalPrice,
                              totalSeat: choosenSeat,
                            )));
              }
            }),
          ],
        ),
      ),
    );
  }

  buildcarFeature(String value, String feature) {
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              feature,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildImage(String urlImage, int index) => Container(
      //margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.fitHeight,
      ),
    );
