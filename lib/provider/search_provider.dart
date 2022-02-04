import 'package:flutter/material.dart';
import 'package:new_turki/models/search_data.dart';
import 'package:new_turki/repository/search_repository.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  List<SearchData> _searchData = [];

  List<SearchData> get searchData => _searchData; //search result
  Future<void> getSearchResultList() async {
    _isLoading = true;
    try {
      _searchData =
          await SearchRepository().getSearchResultList(searchController.text);
    } catch (e) {
      _searchData = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
