import 'package:flutter/material.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/rides.dart';
import 'package:xechung/widget/customButton2.dart';

class chooseTravelDate extends StatefulWidget {
  final Rides rides;
  const chooseTravelDate({Key? key, required this.rides}) : super(key: key);

  @override
  State<chooseTravelDate> createState() => _chooseTravelDateState();
}

class _chooseTravelDateState extends State<chooseTravelDate> {
  int selectedItem = 0;
  List<String> _selected = [];
  bool isChoosen = false;
  int secondaryIndex = 0;
  late List<dynamic> list = widget.rides.daysOfWeek;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return customRadio(list[index], index);
              }),
        ),
        customButton2("Xác nhận", () => Navigator.pop(context, _selected))
      ],
    ));
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
