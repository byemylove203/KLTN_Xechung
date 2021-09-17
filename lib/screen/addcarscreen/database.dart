import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class getDatabase {
  Future<List<Map>> getData() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "data.sqlite");
// delete existing if any
    await deleteDatabase(path);
// Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
// Copy from asset
    ByteData data = await rootBundle.load(join("assets/data", "data.sqlite"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes, flush: true);
// open the database
    var db = await openDatabase(path, readOnly: true);
    List<Map> list = await db.rawQuery('SELECT name FROM tinhthanhpho');
    return list;
  }
}
