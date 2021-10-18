import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/customButton2.dart';

class calendarPopUp extends StatefulWidget {
  @override
  State<calendarPopUp> createState() => _calendarPopUpState();
}

class _calendarPopUpState extends State<calendarPopUp> {
  String _startDate = "";
  @override
  Widget build(BuildContext context) {
    DateRangePickerController dateController = DateRangePickerController();
    return AlertDialog(
      content: SizedBox(
        //HERE THE SIZE YOU WANT
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width / 2,
        //your content
        child: Column(
          children: [
            Center(
              child: SfDateRangePicker(
                controller: dateController,

                //onSelectionChanged: selectionChanged,
                enablePastDates: false,
                selectionColor: Constants.kPrimaryColor,
                onSelectionChanged: selectionChanged,
                // rangeSelectionColor: Constants.kPrimaryColor,
                todayHighlightColor: Constants.kPrimaryColor,
                startRangeSelectionColor: Constants.kPrimaryColor,
                endRangeSelectionColor: Constants.kPrimaryColor,
                selectionMode: DateRangePickerSelectionMode.single,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Spacer(),
            customButton2("Xác nhận", () {
              Navigator.of(context).pop(_startDate);
            })
          ],
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate =
          DateFormat('dd/M/yyyy').format(args.value.startDate).toString();
    });
  }
}
