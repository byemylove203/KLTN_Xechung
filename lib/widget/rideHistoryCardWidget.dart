import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/const/const.dart';
import 'package:xechung/model/bookedOders.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:xechung/model/rides.dart';

import 'package:xechung/screen/messagescreen/chat.dart';
import 'package:xechung/screen/ratingscreen/ratingDriverScreen.dart';

class RideHistoryCardWidget extends StatefulWidget {
  final Rides rides;
  final BookedOrders bookedOrders;
  //final int? index;

  RideHistoryCardWidget({required this.rides, required this.bookedOrders});

  @override
  State<RideHistoryCardWidget> createState() => _RideHistoryCardWidgetState();
}

class _RideHistoryCardWidgetState extends State<RideHistoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //       alignment: Alignment.bottomCenter,
        //       type: PageTransitionType.size,
        //       duration: Duration(milliseconds: 400),
        //       reverseDuration: Duration(milliseconds: 400),
        //       child: rideDetail(
        //         rides: rides,
        //       )),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          height: 350,
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
                      backgroundImage: AssetImage(widget.rides.imageURL),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.bookedOrders.driverID,
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
                            widget.bookedOrders.price.toString() + "đ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Đã đặt " +
                              widget.bookedOrders.bookedSeat.toString() +
                              " chỗ")
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
                            child:
                                Text("- " + widget.bookedOrders.pickupLocation),
                          ),
                          Divider(),
                          Text(
                            "Xuống tại:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                Text("- " + widget.bookedOrders.dropLocation),
                          ),
                        ]),
                  ),
                ],
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    border: Border(
                        //  top: BorderSide(color: Colors.black26),
                        bottom: BorderSide(color: Colors.black26))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.rides.startHour.hour.toString() +
                          ":" +
                          widget.rides.startHour.minute.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.rides.carInfo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          //  top: BorderSide(color: Colors.black26),
                          bottom: BorderSide(color: Colors.black26))),
                  child: Text(
                    widget.bookedOrders.status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red[300]),
                  ),
                ),
              ),
              widget.bookedOrders.status == "Đã hoàn thành"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Constants.kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextButton(
                                onPressed: () {
                                  print(widget.rides.driverUID);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RatingDriverScreen(
                                                  rides: widget.rides)));
                                },
                                child: Text(
                                  "Đánh giá",
                                  style: TextStyle(color: Colors.white),
                                ))),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Constants.kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextButton(
                                onPressed: startMessage,
                                child: Text(
                                  "Liên hệ tài xế",
                                  style: TextStyle(color: Colors.white),
                                ))),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void startMessage() async {
    final room = await FirebaseChatCore.instance.createRoom(
      types.User(
        firstName: "abc",
        id: widget.bookedOrders.driverUID,
        imageUrl: 'https://i.pravatar.cc/300',
        lastName: "DEF",
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }
}
