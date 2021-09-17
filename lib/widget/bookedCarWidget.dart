import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xechung/model/bookedOders.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/screen/bookingHistory/confirmReturnCar.dart';

class bookedCarWidget extends StatelessWidget {
  final bookedOrders orders;
  bookedCarWidget({
    required this.orders,
  });
  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    Car car = Car("t", ["imageUrl"], "price", "descripstion", "feature",
        "carID", "status", true, true);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('carInfo')
            .where('Car ID', isEqualTo: orders.carID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //final carInfo = snapshot.data!.docs;

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => confirmReturnCar(
                          car: car,
                        )),
              );
            },
            child: Container(
              height: widgetHeight,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: snapshot.data!.docs.map((document) {
                  car = Car(
                      document['Type'],
                      ["assets/images/car.jpeg", "assets/images/car_1.jpeg"],
                      orders.price,
                      document['Description'],
                      document['Features'],
                      document['Car ID'],
                      document['Status'],
                      true,
                      true);
                  return Column(
                    children: [
                      Container(
                        color: Colors.green,
                        child: SizedBox(
                          height: widgetHeight / 6,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text("User Name"),
                                Spacer(
                                  flex: 2,
                                ),
                                Text(car.status)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widgetHeight / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(car.imageUrl[0]),
                                        fit: BoxFit.cover)),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            car.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Thời gian đặt xe",
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widgetHeight / 6,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("Thành tiền: " + car.price),
                          ),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
