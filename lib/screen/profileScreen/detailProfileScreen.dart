import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:xechung/const/const.dart';
import 'package:xechung/widget/RateSumaryWidget.dart';
import 'package:xechung/widget/RateWidget.dart';
import 'package:xechung/widget/customButton2.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailProfileScreen extends StatefulWidget {
  const DetailProfileScreen({Key? key}) : super(key: key);

  @override
  _DetailProfileScreenState createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final tabs = [
    'Tab 1',
    'Tab 2',
  ];
  final FocusNode myFocusNode = FocusNode();
  bool _status = true;
  TextEditingController gmailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    firstNameController = getSurName();
    lastNameController = getLastName();
    gmailController = getGmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    final phoneNumber = user!.phoneNumber;
    final uid = user.uid;
    final phoneNumberController = TextEditingController(text: phoneNumber);
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: new IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 22.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              indicatorColor: Constants.kPrimaryColor,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "Thông tin",
                ),
                Tab(
                  text: "Đánh giá",
                ),
              ],
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 12),
              child: new Text('Hồ sơ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black)),
            ),
          ),
          body: TabBarView(
            children: [
              new Container(
                color: Colors.white,
                child: new ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        new Container(
                          height: 200.0,
                          color: Colors.white,
                          child: new Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: new Stack(
                                    fit: StackFit.loose,
                                    children: <Widget>[
                                      new Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                              width: 140.0,
                                              height: 140.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                  image: new ExactAssetImage(
                                                      'assets/images/user_1.jpeg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: 90.0, right: 100.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new CircleAvatar(
                                                backgroundColor:
                                                    Constants.kPrimaryColor,
                                                radius: 25.0,
                                                child: new Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 25.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Thông tin cá nhân',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditIcon()
                                                : new Container(),
                                          ],
                                        )
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'Họ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: new Text(
                                              'Tên',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: firstNameController,
                                              decoration: const InputDecoration(
                                                  hintText: "Nhập họ"),
                                              enabled: !_status,
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        Flexible(
                                          child: new TextField(
                                            controller: lastNameController,
                                            decoration: const InputDecoration(
                                                hintText: "Nhập tên"),
                                            enabled: !_status,
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Địa chỉ Email',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: gmailController,
                                            decoration: const InputDecoration(
                                                hintText: "Enter Email ID"),
                                            enabled: !_status,
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              'Số điện thoại',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Flexible(
                                          child: new TextField(
                                            controller: phoneNumberController,
                                            decoration: const InputDecoration(),
                                            // hintText: "Enter Mobile Number"),
                                            enabled: false,
                                          ),
                                        ),
                                      ],
                                    )),
                                !_status
                                    ? _getActionButtons()
                                    : new Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rate')
                      .where('Driver UID', isEqualTo: uid.toString())
                      .orderBy('Date Rated', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return RateSumaryWidget(
                              totalRate: snapshot.data!.docs.map((document) {
                            return document['Rate'];
                          }).toList());
                        } else {
                          DocumentSnapshot rate =
                              snapshot.data!.docs[index - 1];
                          return RateWidget(
                              userUID: rate['User UID'],
                              rateID: rate['Rate ID'],
                              comment: rate['Comment'],
                              rate: rate['Rate'],
                              timeRated: rate['Date Rated'].toDate());
                        }
                      },
                    );
                  }),
            ],
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  TextEditingController getSurName() {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    final uid = user!.uid;
    final surNameController = TextEditingController();
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.exists) {
        String firstName = querySnapshot.data()!['firstName'];
        surNameController.text = firstName;
      }
    });
    return surNameController;
  }

  TextEditingController getLastName() {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final lastNameController = TextEditingController();
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.exists) {
        String firstName = querySnapshot.data()!['lastName'];
        lastNameController.text = firstName;
      }
    });
    return lastNameController;
  }

  TextEditingController getGmail() {
    final _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final gmailController = TextEditingController();
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.exists) {
        String firstName = querySnapshot.data()!['lastName'];
        gmailController.text = firstName;
      }
    });
    return gmailController;
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Lưu"),
                textColor: Colors.white,
                color: Constants.kPrimaryColor,
                onPressed: () async {
                  final _auth = FirebaseAuth.instance;
                  final User? user = _auth.currentUser;
                  final uid = user!.uid;

                  await FirebaseChatCore.instance.createUserInFirestore(
                    types.User(
                        firstName: firstNameController.text,
                        id: uid, // UID from Firebase Authentication
                        imageUrl: 'https://i.pravatar.cc/300',
                        lastName: lastNameController.text),
                  );
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  String getTotalRate(List totalRate) {
    return 'aaa';
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Constants.kPrimaryColor,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Column(
//             children: [
//               customButton2("Thêm tài khoản", () async {
//                 final _auth = FirebaseAuth.instance;
//                 final User? user = _auth.currentUser;
//                 final uid = user!.uid;
//                 final phoneNumber = user.phoneNumber;

//                 await FirebaseChatCore.instance.createUserInFirestore(
//                   types.User(
//                     firstName: phoneNumber,
//                     id: uid, // UID from Firebase Authentication
//                     imageUrl: 'https://i.pravatar.cc/300',
//                     lastName: ' bii',
//                   ),
//                 );
//               })
//             ],
//           ),
//         ));
//   }
// }
