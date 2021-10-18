import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/bookedOders.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:xechung/model/rides.dart';
import 'package:xechung/screen/messagescreen/MessageScreen.dart';
import 'package:xechung/screen/messagescreen/chat.dart';

class RideRequestCardWidget extends StatefulWidget {
  final Rides rides;
  final BookedOrders bookedOrders;
  //final int? index;

  RideRequestCardWidget({required this.rides, required this.bookedOrders});

  @override
  State<RideRequestCardWidget> createState() => _RideRequestCardWidgetState();
}

class _RideRequestCardWidgetState extends State<RideRequestCardWidget> {
  bool confirmOrCancelVisible = false;
  bool chooseStartPickupClientVisible = false;
  bool toPickupPointVisible = false;
  bool startTravelVisible = false;
  bool finishedVisible = false;
  bool rateVisible = false;
  void checkStatus() {
    if (widget.bookedOrders.status == "Đang chờ xác nhận") {
      confirmOrCancelVisible = true;
    }

    if (widget.bookedOrders.status == "Tài xế đã xác nhận") {
      confirmOrCancelVisible = false;
      chooseStartPickupClientVisible = true;
    }

    if (widget.bookedOrders.status == "Tài xế đang trên đường đón") {
      confirmOrCancelVisible = false;
      chooseStartPickupClientVisible = false;
      toPickupPointVisible = true;
    }

    if (widget.bookedOrders.status == "Tài xế đã tới điểm đón") {
      confirmOrCancelVisible = false;
      chooseStartPickupClientVisible = false;
      toPickupPointVisible = false;
      startTravelVisible = true;
    }

    if (widget.bookedOrders.status == "Bắt đầu chuyến đi") {
      confirmOrCancelVisible = false;
      chooseStartPickupClientVisible = false;
      toPickupPointVisible = false;
      startTravelVisible = false;
      finishedVisible = true;
    }

    if (widget.bookedOrders.status == "Đã hoàn thành") {
      confirmOrCancelVisible = false;
      chooseStartPickupClientVisible = false;
      toPickupPointVisible = false;
      startTravelVisible = false;
      finishedVisible = false;
      rateVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    int rideID = 0;

    checkStatus();

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
          height: 325,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                        Text(widget.bookedOrders.clientUserID,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "Đón vào lúc " +
                          widget.rides.startHour.hour.toString() +
                          ":" +
                          widget.rides.startHour.minute.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              //////////////////////////
              Visibility(
                visible: confirmOrCancelVisible,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                              onPressed: () {
                                if (widget.bookedOrders.status ==
                                    "Đang chờ xác nhận") {
                                  CollectionReference orderStatus =
                                      FirebaseFirestore.instance
                                          .collection('bookingOrder');
                                  orderStatus
                                      .doc(widget.bookedOrders.orderID
                                          .toString())
                                      .update({'Status': 'Tài xế đã huỷ'});
                                }
                              },
                              child: Text(
                                "Từ chối",
                                style: TextStyle(color: Colors.white),
                              ))),
                      Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Constants.kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                              onPressed: () {
                                if (widget.bookedOrders.status ==
                                    "Đang chờ xác nhận") {
                                  FirebaseFirestore.instance
                                      .collection("Rides")
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((result) {
                                      rideID = result.data()['Rides ID'];
                                      if (rideID ==
                                          widget.bookedOrders.orderID) {
                                        int avaiableSeat =
                                            (result.data()['Seat']) -
                                                widget.bookedOrders.bookedSeat;

                                        CollectionReference changeAvaiableSeat =
                                            FirebaseFirestore.instance
                                                .collection("Rides");
                                        changeAvaiableSeat
                                            .doc((rideID).toString())
                                            .update({'Seat': avaiableSeat});
                                      }
                                    });
                                  });
                                  CollectionReference orderStatus =
                                      FirebaseFirestore.instance
                                          .collection('bookingOrder');
                                  orderStatus
                                      .doc(widget.bookedOrders.orderID
                                          .toString())
                                      .update({'Status': 'Tài xế đã xác nhận'});
                                  setState(() {
                                    confirmOrCancelVisible = false;
                                    chooseStartPickupClientVisible = true;
                                  });
                                }
                              },
                              child: Text(
                                "Đồng ý",
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: chooseStartPickupClientVisible,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Constants.kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                              onPressed: () {
                                CollectionReference orderStatus =
                                    FirebaseFirestore.instance
                                        .collection('bookingOrder');
                                orderStatus
                                    .doc(widget.bookedOrders.orderID.toString())
                                    .update({
                                  'Status': 'Tài xế đang trên đường đón'
                                });
                                setState(() {
                                  chooseStartPickupClientVisible = false;
                                  toPickupPointVisible = true;
                                });
                              },
                              child: Text(
                                "Bắt đầu đón khách",
                                style: TextStyle(color: Colors.white),
                              ))),
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
                                "Nhắn tin với khách",
                                style: TextStyle(color: Colors.white),
                              ))),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: toPickupPointVisible,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Constants.kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                              onPressed: () {
                                CollectionReference orderStatus =
                                    FirebaseFirestore.instance
                                        .collection('bookingOrder');
                                orderStatus
                                    .doc(widget.bookedOrders.orderID.toString())
                                    .update(
                                        {'Status': 'Tài xế đã tới điểm đón'});
                                setState(() {
                                  toPickupPointVisible = false;
                                  startTravelVisible = true;
                                });
                              },
                              child: Text(
                                "Đã tới điểm đón",
                                style: TextStyle(color: Colors.white),
                              ))),
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
                                "Nhắn tin với khách",
                                style: TextStyle(color: Colors.white),
                              ))),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: startTravelVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Constants.kPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                            onPressed: () {
                              CollectionReference orderStatus =
                                  FirebaseFirestore.instance
                                      .collection('bookingOrder');
                              orderStatus
                                  .doc(widget.bookedOrders.orderID.toString())
                                  .update({'Status': 'Bắt đầu chuyến đi'});
                              setState(() {
                                startTravelVisible = false;
                                finishedVisible = true;
                              });
                            },
                            child: Text(
                              "Đã đón khách",
                              style: TextStyle(color: Colors.white),
                            ))),
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
                              "Nhắn tin với khách",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ],
                ),
              ),
              Visibility(
                visible: finishedVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Constants.kPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                            onPressed: () {
                              CollectionReference orderStatus =
                                  FirebaseFirestore.instance
                                      .collection('bookingOrder');
                              orderStatus
                                  .doc(widget.bookedOrders.orderID.toString())
                                  .update({'Status': 'Đã hoàn thành'});
                              setState(() {
                                finishedVisible = false;
                                rateVisible = true;
                              });
                            },
                            child: Text(
                              "Hoàn thành",
                              style: TextStyle(color: Colors.white),
                            ))),
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
                              "Nhắn tin với khách",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ],
                ),
              ),
              Visibility(
                visible: rateVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 35,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Constants.kPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                            onPressed: () {
                              // CollectionReference orderStatus =
                              //     FirebaseFirestore.instance
                              //         .collection('bookingOrder');
                              // orderStatus
                              //     .doc(widget.bookedOrders.orderID.toString())
                              //     .update({'Status': 'Đã hoàn thành'});
                              // setState(() {
                              //   finishedVisible = false;
                              //   rateVisible = true;
                              // });
                            },
                            child: Text(
                              "Đánh giá khách",
                              style: TextStyle(color: Colors.white),
                            ))),
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
                              "Nhắn tin với khách",
                              style: TextStyle(color: Colors.white),
                            ))),
                  ],
                ),
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
        id: widget.bookedOrders.clientUID,
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
