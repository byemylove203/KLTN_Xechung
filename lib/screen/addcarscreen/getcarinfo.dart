import 'package:flutter/material.dart';
import 'package:vin_decoder/vin_decoder.dart';

class getcarinfo extends StatelessWidget {
  final cartypeController = TextEditingController();
  getcarinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Column(
            children: [
              SizedBox(height: 100),
              TextField(
                controller: cartypeController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'What car do you have?',
                ),
              ),
              TextButton(
                  onPressed: () async {
                    var vin =
                        VIN(number: cartypeController.text, extended: true);
                    var make = await vin.getMakeAsync();
                    var model = await vin.getModelAsync();
                    var year = vin.getYear().toString();
                    String carInfomation = "${year} ${make} ${model}";
                    Navigator.pop(context, carInfomation);
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
//chuyển sateless sang stateful để hiện phần showloading, hiện info xe lên row