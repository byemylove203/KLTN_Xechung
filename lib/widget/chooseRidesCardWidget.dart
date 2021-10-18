import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/screen/chooseRidesScreen/rideDetail.dart';

class chooseRidesCardWidget extends StatelessWidget {
  final Rides rides;
  //final int? index;

  chooseRidesCardWidget({required this.rides});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              alignment: Alignment.bottomCenter,
              type: PageTransitionType.size,
              duration: Duration(milliseconds: 400),
              reverseDuration: Duration(milliseconds: 400),
              child: rideDetail(
                rides: rides,
              )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 280,
          //margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
            // color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            // border: Border.all(
            //   width: 1,
            // ),
          ),
          // margin: EdgeInsets.only(
          //     right: index != null ? 16 : 0,
          //     left: index == 0 ? 16 : 0,
          //     bottom: 16),
          //width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(rides.imageURL),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(rides.userName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("100 đánh giá"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            rides.price.toString() + "đ/chỗ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Còn " + rides.avaiableSeats.toString() + " chỗ")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, right: 5),
                        child: Icon(
                          Ionicons.ellipse_outline,
                          color: Colors.blue[200],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 5),
                        child: Icon(
                          Ionicons.location_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đón tại:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("- " + rides.startLocation),
                          ),
                          Divider(),
                          Text(
                            "Xuống tại:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("- " + rides.endLocation),
                          ),
                        ]),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Bắt đầu lúc",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        rides.startHour.hour.toString() +
                            ":" +
                            rides.startHour.minute.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    rides.carInfo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Constants.kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Đi chung",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
