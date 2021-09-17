import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/headertext.dart';
import 'package:xechung/widget/carWidget.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  //List<Car> cars = getCarList();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
          ),
          buildHomeScreen(),
        ],
      )),
    );
  }

  buildHomeScreen() => SliverToBoxAdapter(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('carInfo')
                .where('Status', isEqualTo: 'notHired')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                SizedBox(
                  height: 10,
                ),
                headerText(
                  "SLOGAN",
                  FontWeight.bold,
                  size: 25,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      color: Constants.kPrimaryColor,
                      child: Text(
                        "SEARCH",
                      )),
                ),
                headerText(
                  "Khám phá xe cho thuê gần bạn",
                  FontWeight.bold,
                  size: 25,
                ),
                Container(
                  // padding: EdgeInsets.all(8),
                  height: 300,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.docs.map((document) {
                      //ktra xem status xe chua bi thue thi hien len task 17/9
                      return carWidget(
                          car: Car(
                              document['Type'],
                              [
                                "assets/images/car.jpeg",
                                "assets/images/car_1.jpeg"
                              ],
                              document['Odormeter'],
                              document['Description'],
                              document['Features'],
                              document['Car ID'],
                              document['Status'],
                              true,
                              true));
                    }).toList(),
                  ),
                )
              ]);
            }),
      );

  // List<Widget> buildNewestCar() {
  //   List<Widget> list = [];

  //   for (var i = 0; i < cars.length; i++) {
  //     if (cars[i].newest) {
  //       list.add(carWidget(
  //         car: cars[i],
  //       ));
  //     }
  //   }
  //   return list;
  // }
}
// StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('carInfo')
//                   .where('Status', isEqualTo: 'notHired')
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     headerText(
//                       "SLOGAN",
//                       FontWeight.bold,
//                       size: 25,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 4,
//                       width: MediaQuery.of(context).size.width,
//                       child: Container(
//                           color: Constants.kPrimaryColor,
//                           child: Text(
//                             "SEARCH",
//                           )),
//                     ),
//                     headerText(
//                       "Khám phá xe cho thuê gần bạn",
//                       FontWeight.bold,
//                       size: 25,
//                     ),
//                     Container(
//                       // padding: EdgeInsets.all(8),
//                       height: 300,
//                       child: ListView(
//                         padding: EdgeInsets.symmetric(horizontal: 24),
//                         physics: BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         children: snapshot.data!.docs.map((document) {
//                           //ktra xem status xe chua bi thue thi hien len task 17/9
//                           return carWidget(
//                               car: Car(
//                                   document['Type'],
//                                   [
//                                     "assets/images/car.jpeg",
//                                     "assets/images/car_1.jpeg"
//                                   ],
//                                   document['Odormeter'],
//                                   document['Description'],
//                                   document['Features'],
//                                   document['Car ID'],
//                                   document['Status'],
//                                   true,
//                                   true));
//                         }).toList(),
//                       ),
//                     )
//                   ],
//                 );
//               }),