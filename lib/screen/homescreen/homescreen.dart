import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xechung/model/car.dart';

import 'package:xechung/widget/customtext.dart';
import 'package:xechung/widget/carWidget.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final double expandedHeight = 400;

  //List<Car> cars = getCarList();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 65,
                stretch: true,
                backgroundColor: Colors.white,
                expandedHeight: expandedHeight,
                pinned: true,
                title: buildSearchBar(),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/homescreen.jpg",
                        fit: BoxFit.cover,
                      ),
                      //Note: Muốn thêm widget gì thì thêm vào đây
                    ],
                  ),
                ),
              ),
              buildHomeScreen(),
            ],
          )),
    );
  }

  buildSearchBar() => Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                textAlign: TextAlign.center,
                onChanged: (value) {},
                cursorColor: Colors.black,
                decoration: new InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Bạn muốn đi đâu?",
                    hoverColor: Colors.black),
              ),
            ),
          ),
        ],
      );

  buildHomeScreen() => SliverToBoxAdapter(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('carInfo')
                .where('Status', isEqualTo: 'Có sẵn')
                .where('User', isNotEqualTo: 'None')
                .orderBy('User')
                .orderBy('Car ID', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (Text(
                    "SLOGAN",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                ),
                Divider(),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 4,
                //   width: MediaQuery.of(context).size.width,
                //   child: Container(
                //       color: Constants.kPrimaryColor,
                //       child: Text(
                //         "SEARCH",
                //       )),
                // ),
                customText(
                  "Xe Gần bạn",
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
                              document['Images URL'],
                              document['Odormeter'],
                              document['Description'],
                              document['Features'],
                              document['Car ID'],
                              document['User'],
                              document['Status'],
                              true,
                              true));
                    }).toList(),
                  ),
                ),
                customText(
                  "Phổ biến",
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
                              document['Images URL'],
                              document['Odormeter'],
                              document['Description'],
                              document['Features'],
                              document['Car ID'],
                              document['User'],
                              document['Status'],
                              true,
                              true));
                    }).toList(),
                  ),
                )
              ]);
            }),
      );
}
