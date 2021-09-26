import 'package:flutter/material.dart';
import 'package:places_service/places_service.dart';

class applicationBloc with ChangeNotifier {
  final placesService = PlacesService();
//Variables
  List<PlacesAutoCompleteResult> searchResults = [];

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }
}
