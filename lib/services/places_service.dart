import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:xechung/model/placeSearch.dart';

class PlaceService {
  final key = 'AIzaSyAKPveAbIHRL4sIAmEGgvnUQ1Q3C5zluko';
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&location=37.76999%2C-122.44696&radius=500&types=establishment&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
