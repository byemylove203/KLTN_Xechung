import 'package:flutter/material.dart';

import 'package:google_place/google_place.dart';
import 'package:xechung/widget/customButton2.dart';

class searchForEndPoint extends StatefulWidget {
  const searchForEndPoint({Key? key}) : super(key: key);

  @override
  _searchForEndPointState createState() => _searchForEndPointState();
}

class _searchForEndPointState extends State<searchForEndPoint> {
  GooglePlace? googlePlace;
  TextEditingController locationController = TextEditingController();
  List<AutocompletePrediction> predictions = [];
  String location = "";
  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyAKPveAbIHRL4sIAmEGgvnUQ1Q3C5zluko');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Search",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  location = value;
                  // print(location);
                  if (value.isNotEmpty) {
                    //autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                        location = value;
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index].description.toString()),
                      onTap: () async {
                        debugPrint(predictions[index].reference);

                        setState(() {
                          locationController.text =
                              predictions[index].description.toString();
                        });
                      },
                    );
                  },
                ),
              ),
              customButton2("Xong", () {
                Navigator.pop(context, locationController.text);
              })
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(
      value,
      region: "vn",
      language: "vi",
      types: "address",
    );
    print(result!.status);

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
