import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class searchHint extends StatefulWidget {
  const searchHint({Key? key}) : super(key: key);

  @override
  _searchHintState createState() => _searchHintState();
}

class _searchHintState extends State<searchHint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gợi ý"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Ionicons.close_circle_outline),
          color: Colors.black,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
    );
  }
}
