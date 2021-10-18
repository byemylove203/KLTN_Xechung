import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/confirmAddNewCar.dart';
import 'package:xechung/screen/addcarscreen/description.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customtext.dart';

class carFeatures extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  final Map<String, dynamic>? rides;
  const carFeatures({Key? key, this.carInfo, this.rides}) : super(key: key);

  @override
  _carFeaturesState createState() => _carFeaturesState();
}

class _carFeaturesState extends State<carFeatures> {
  List<String> list = [
    'Thứ 2',
    'Thứ 4',
    'Thứ 6',
    'Chủ nhật',
    'Camera 360',
    'Thứ 3',
    'Thứ 5',
    'Thứ 7',
    'Ghế chỉnh điện',
    'Sạc không dây'
  ];
  bool isChoosen = false;
  int selectedItem = 0;
  List<String> _selected = [];

  int secondaryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Ionicons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          customText(
            "Chọn ngày xe đi",
            FontWeight.bold,
            size: 30,
          ),
          customText(
            "Chọn những ngày bạn đi trong tuần.",
            FontWeight.normal,
            size: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  customRadio(list[0], 0),
                  customRadio(list[1], 1),
                  customRadio(list[2], 2),
                  customRadio(list[3], 3),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  customRadio(list[5], 5),
                  customRadio(list[6], 6),
                  customRadio(list[7], 7),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextButton(
                  child: Text(
                    "TIẾP TỤC",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: isChoosen
                        ? MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor)
                        : MaterialStateProperty.all<Color>(Colors.grey),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor: isChoosen
                        ? MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor)
                        : MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    if (isChoosen == true) {
                      Map<String, dynamic> daysOfWeek = {
                        "Days Of Week": _selected
                      };
                      Map<String, dynamic> features = {
                        "Features": _selected.join(",")
                      };

                      Map<String, dynamic> rides = {
                        ...widget.rides!,
                        ...daysOfWeek
                      };
                      print(rides);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => confirmAddNewCar(
                                    carInfo: rides,
                                    rides: rides,
                                  )));
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void selectedItems(int index) {
    setState(() {
      selectedItem = index;
      final isSelected = _selected.contains(list.elementAt(index));
      isSelected
          ? _selected.remove(list.elementAt(index))
          : _selected.add(list.elementAt(index));
      if (_selected.isNotEmpty)
        isChoosen = true;
      else
        isChoosen = false;
    });
  }

  Widget customRadio(String text, int index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: 80.0,
        width: 182.0,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              side: BorderSide(
                  width: 2,
                  color: _selected.contains(list.elementAt(index))
                      ? Color(0xff56C596)
                      : Colors.grey)),
          onPressed: () => selectedItems(index),
          child: Row(
            children: [
              Icon(Constants.featureIcon[index],
                  size: 30,
                  color: _selected.contains(list.elementAt(index))
                      ? Color(0xff56C596)
                      : Colors.grey),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                      color: _selected.contains(list.elementAt(index))
                          ? Color(0xff56C596)
                          : Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeSecondaryIndex(int index) {
    setState(() {
      secondaryIndex = index;
    });
  }
}
