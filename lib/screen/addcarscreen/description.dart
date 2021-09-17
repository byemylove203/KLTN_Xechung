import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:xechung/const/const.dart';
import 'package:xechung/screen/addcarscreen/confirmAddNewCar.dart';
import 'package:xechung/widget/headertext.dart';

class description extends StatefulWidget {
  final Map<String, dynamic>? carInfo;
  const description({Key? key, this.carInfo}) : super(key: key);

  @override
  _descriptionState createState() => _descriptionState();
}

class _descriptionState extends State<description> {
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Ionicons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerText(
                "Mô tả",
                FontWeight.bold,
                size: 30,
              ),
              headerText(
                "Cho khách hàng biết vì sao họ nên thuê xe của bạn.",
                FontWeight.normal,
                size: 16,
              ),
              headerText(
                "Bạn nên tả cái gì?",
                FontWeight.bold,
                size: 20,
                color: Constants.kPrimaryColor,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  children: [
                    Icon(
                      Ionicons.car_outline,
                      color: Color(0xff56c596),
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Những bài đăng với mô tả từ 100 từ trở lên thường sẽ được khách hàng để ý nhiều hơn.",
                            style: TextStyle(fontSize: 14),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 10,
                  cursorColor: Color(0xff56c596),
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Color(0xff56c596),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText:
                          "Bạn không cần phải thêm thông tin liên lạc của mình hoặc chỉ dẫn lấy xe, khách hàng sẽ nhận được những thứ đó khi họ tiến hành thuê xe của bạn."),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
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
                      Map<String, dynamic>? desciption = {
                        "Description": descriptionController.text,
                      };
                      Map<String, dynamic>? carInfo = {
                        ...widget.carInfo!,
                        ...desciption
                      };
                      print(carInfo);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => confirmAddNewCar(
                                    carInfo: carInfo,
                                  )));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
