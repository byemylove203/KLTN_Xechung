import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/const/const.dart';

import 'package:xechung/model/car.dart';
import 'package:xechung/screen/hostedcarscreen/editcarscreen.dart';

class hostedCarwidget extends StatelessWidget {
  final Car car;
  hostedCarwidget({required this.car});
  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => editcarScreen(
                    car: car,
                  )),
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              //   margin: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                height: widgetHeight / 6,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Ionicons.people),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(car.userID),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        car.status,
                        style: TextStyle(color: Constants.kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widgetHeight / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(car.imageUrl[0]),
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
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: Align(
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         "Thời gian đặt xe",
                          //         style: TextStyle(fontSize: 18),
                          //       )),
                          // ),
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
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Giá thuê: " + car.price),
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey[100],
              height: 10,
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
