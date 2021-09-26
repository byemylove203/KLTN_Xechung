import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';
import 'package:xechung/services/address_selection_view.dart';

class AddressSelectionViewModel extends FormViewModel {
  final PlacesService _placeService;
  List<PlacesAutoCompleteResult> _autoCompeleResults = [];

  AddressSelectionViewModel(this._placeService);
  List<PlacesAutoCompleteResult> get autocompleteResults => _autoCompeleResults;
  bool get hasAutoCompleteResults => _autoCompeleResults.isNotEmpty;
  @override
  void setFormStatus() {
    _getAutoCompleteResults();
  }

  Future<void> _getAutoCompleteResults() async {
    if (addressValue != null) {
      final placesResults = await _placeService.getAutoComplete(addressValue!);

      if (placesResults != null) {
        _autoCompeleResults = placesResults.cast<PlacesAutoCompleteResult>();
        notifyListeners();
      }
    }
  }
}
