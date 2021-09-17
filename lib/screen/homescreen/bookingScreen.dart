import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/model/car.dart';
import 'package:xechung/screen/homescreen/pickingLocation.dart';
import 'package:xechung/widget/bookingDetails.dart';

class bookingScreen extends StatefulWidget {
  final Car? car;
  const bookingScreen({Key? key, this.car}) : super(key: key);
  @override
  _bookingScreenState createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen> {
  TimeOfDay _startTime = TimeOfDay.now().replacing(minute: 30);
  TimeOfDay _endTime = TimeOfDay.now().replacing(minute: 30);
  String _startDate = "Ngày đặt", _endDate = "Ngày trả";
  DateRangePickerController dateController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: TextButton(
              child: Text(
                "Đặt lại",
                style: TextStyle(color: Constants.kPrimaryColor, fontSize: 16),
              ),
              onPressed: () {
                setState(() {
                  dateController.selectedRange =
                      PickerDateRange(DateTime.now(), DateTime.now());
                });
              },
            ),
          ),
        ],
        title: Text(
          "Chọn thời gian đặt xe",
          style: TextStyle(
            color: Color.fromRGBO(33, 45, 82, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SfDateRangePicker(
                  controller: dateController,

                  onSelectionChanged: selectionChanged,
                  enablePastDates: false,
                  selectionColor: Constants.kPrimaryColor,

                  // rangeSelectionColor: Constants.kPrimaryColor,
                  todayHighlightColor: Constants.kPrimaryColor,
                  startRangeSelectionColor: Constants.kPrimaryColor,
                  endRangeSelectionColor: Constants.kPrimaryColor,
                  selectionMode: DateRangePickerSelectionMode.range,
                  headerStyle: DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              BookingDetails(_startDate, _endDate),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      iosStylePicker: true,
                      is24HrFormat: true,
                      context: context,
                      value: _startTime,
                      onChange: onTimeChanged,
                    ),
                  );
                },
                child: Text(
                  "Giờ đặt " +
                      _startTime.format(context) +
                      " ngày " +
                      _startDate,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    showPicker(
                      iosStylePicker: true,
                      is24HrFormat: true,
                      context: context,
                      value: _endTime,
                      onChange: onTimeChanged,
                    ),
                  );
                },
                child: Text(
                  "Giờ trả " + _endTime.format(context) + " ngày " + _endDate,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              //BookingPropertyFeatures(),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pickingLocation(
                                  car: widget.car,
                                )));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd/M/yyyy').format(args.value.startDate).toString();
      _endDate = DateFormat('dd/M/yyyy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _startTime = newTime;
    });
  }
}
