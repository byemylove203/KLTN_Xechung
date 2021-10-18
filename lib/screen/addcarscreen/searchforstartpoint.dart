import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_place/google_place.dart';
import 'package:xechung/widget/customButton2.dart';

class searchForStartPoint extends StatefulWidget {
  const searchForStartPoint({Key? key}) : super(key: key);

  @override
  _searchForStartPointState createState() => _searchForStartPointState();
}

class _searchForStartPointState extends State<searchForStartPoint> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(21.027763, 105.834160), zoom: 11.5);
  GooglePlace? googlePlace;
  TextEditingController locationController = TextEditingController();
  List<AutocompletePrediction> predictions = [];
  String location = "";
  late GoogleMapController googleMapController;
  @override
  void initState() {
    googlePlace = GooglePlace('AIzaSyAKPveAbIHRL4sIAmEGgvnUQ1Q3C5zluko');
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        print("s");
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
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: predictions.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         leading: CircleAvatar(
              //           child: Icon(
              //             Icons.pin_drop,
              //             color: Colors.white,
              //           ),
              //         ),
              //         title: Text(predictions[index].description.toString()),
              //         onTap: () {
              //           debugPrint(predictions[index].placeId);
              //           setState(() {
              //             locationController.text =
              //                 predictions[index].description.toString();
              //           });
              //         },
              //       );
              //     },
              //   ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationEnabled: true,
                ),
              ),
              // customButton2("Xong", () {
              //   Navigator.pop(context, locationController.text);
              // })
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
