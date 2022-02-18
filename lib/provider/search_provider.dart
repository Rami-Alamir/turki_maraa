import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/search_data.dart';
import 'package:new_turki/repository/search_repository.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<SearchData> _searchData = [];

  List<SearchData> get searchData => _searchData; //search result
  Future<void> getSearchResultList(LatLng latLng, String isoCountryId) async {
    try {
      _searchData = await SearchRepository()
          .getSearchResultList(searchController.text, latLng, isoCountryId);
    } catch (e) {
      _searchData = [];
    }
    notifyListeners();
  }
}
