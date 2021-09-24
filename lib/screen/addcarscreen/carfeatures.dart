import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xechung/screen/addcarscreen/description.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customtext.dart';

class carFeatures extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  const carFeatures({Key? key, this.carInfo}) : super(key: key);

  @override
  _carFeaturesState createState() => _carFeaturesState();
}

class _carFeaturesState extends State<carFeatures> {
  List<String> list = [
    'Bluetooth',
    'GPS',
    'Cảnh báo điểm mù',
    'Cruise Control',
    'Camera 360',
    'Tự động đỗ xe',
    'Cửa sổ trời',
    'Phanh khẩn cấp',
    'Ghế chỉnh điện',
    'Sạc không dây'
  ];
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
            "Tính năng của xe",
            FontWeight.bold,
            size: 30,
          ),
          customText(
            "Chọn tính năng xe bạn có.",
            FontWeight.normal,
            size: 18,
          ),
          Row(
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
                  customRadio(list[4], 4),
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
                  customRadio(list[8], 8),
                  customRadio(list[9], 9),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Constants.kPrimaryColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Constants.kPrimaryColor),
                  ),
                  onPressed: () {
                    Map<String, dynamic> features = {
                      "Features": _selected.join(",")
                    };

                    Map<String, dynamic> result = {
                      ...widget.carInfo!,
                      ...features,
                    };
                    //print(result);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => description(
                                  carInfo: result,
                                )));
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
