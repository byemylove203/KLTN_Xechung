import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateWidget extends StatefulWidget {
  String userUID;
  String rateID;
  String comment;
  double rate;
  dynamic timeRated;
  RateWidget(
      {required this.userUID,
      required this.rateID,
      required this.comment,
      required this.rate,
      required this.timeRated});

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  String firstName = "";
  String lastName = "";
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    DateTime now = widget.timeRated;

    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    return Column(
      children: [
        Container(
          child: FutureBuilder(
            future: getUserInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
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
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildAvatar(snapshot.data['ImageUrl']),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 5),
                                        child: Text(
                                          snapshot.data['First Name'] +
                                              " " +
                                              snapshot.data['Last Name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            initialRating: widget.rate,
                                            itemSize: 25,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            ignoreGestures: true,
                                            onRatingUpdate: (rating) {
                                              // print(rating);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(widget.rate.toString()),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 5),
                                        child: Text(
                                          widget.comment,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 5),
                                        child:
                                            Text(convertedDateTime.toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget buildAvatar(String url) {
    final hasImage = url != "";
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundImage: hasImage ? NetworkImage(url) : null,
        radius: 20,
      ),
    );
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    Map<String, dynamic> a = {};
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userUID)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.exists) {
        firstName = querySnapshot.data()!['firstName'];
        lastName = querySnapshot.data()!['lastName'];
        imageUrl = querySnapshot.data()!['imageUrl'];

        a = {
          "First Name": firstName,
          "Last Name": lastName,
          "ImageUrl": imageUrl
        };

        return a;
      }
    });
    return a;
  }
}
