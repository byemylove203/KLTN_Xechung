import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xechung/const/const.dart';

class RateSumaryWidget extends StatefulWidget {
  final List totalRate;
  const RateSumaryWidget({Key? key, required this.totalRate}) : super(key: key);

  @override
  State<RateSumaryWidget> createState() => _RateSumaryWidgetState();
}

class _RateSumaryWidgetState extends State<RateSumaryWidget> {
  double oneStar = 0;
  double twoStar = 0;
  double threeStar = 0;
  double fourStar = 0;
  double fiveStar = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(5, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Đánh giá người dùng",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              initialRating:
                                  getAverageRate(widget.totalRate) - 1,
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
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  getAverageRate(widget.totalRate).toString() +
                                      " trên 5"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.totalRate.length.toString() +
                          " người dùng đã đánh giá"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("1 sao"),
                                ),
                                new LinearPercentIndicator(
                                  width: 100.0,
                                  lineHeight: 20,
                                  percent: oneStar,
                                  progressColor: Constants.kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text((oneStar * 100).toString() + "%"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("2 sao"),
                                ),
                                new LinearPercentIndicator(
                                  width: 100.0,
                                  lineHeight: 20,
                                  percent: twoStar,
                                  progressColor: Constants.kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text((twoStar * 100).toString() + "%"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("3 sao"),
                                ),
                                new LinearPercentIndicator(
                                  width: 100.0,
                                  lineHeight: 20,
                                  percent: threeStar,
                                  progressColor: Constants.kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      Text((threeStar * 100).toString() + "%"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("4 sao"),
                                ),
                                new LinearPercentIndicator(
                                  width: 100.0,
                                  lineHeight: 20,
                                  percent: fourStar,
                                  progressColor: Constants.kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      Text((fourStar * 100).toString() + "%"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("5 sao"),
                                ),
                                new LinearPercentIndicator(
                                  width: 100.0,
                                  lineHeight: 20,
                                  percent: fiveStar,
                                  progressColor: Constants.kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      Text((fiveStar * 100).toString() + "%"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double getAverageRate(List totalRate) {
    double average = 0;
    double total = 0;
    double oneStars = 0;
    double twoStars = 0;
    double threeStars = 0;
    double fourStars = 0;
    double fiveStars = 0;
    for (int i = 0; i < totalRate.length; i++) {
      total += totalRate[i];
      if (totalRate[i] == 1) oneStars++;
      if (totalRate[i] == 2) twoStars++;
      if (totalRate[i] == 3) threeStars++;
      if (totalRate[i] == 4) fourStars++;
      if (totalRate[i] == 5) fiveStars++;
    }

    oneStar = oneStars / totalRate.length;
    twoStar = twoStars / totalRate.length;
    threeStar = threeStars / totalRate.length;
    fourStar = fourStars / totalRate.length;
    fiveStar = fiveStars / totalRate.length;
    average = total / totalRate.length;
    return average;
  }
}
