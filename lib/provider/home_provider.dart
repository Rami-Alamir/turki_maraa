import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/repository/products_repository.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;
  bool _foodsIsLoading = true;
  bool _discoverIsLoading = true;

  bool get discoverIsLoading => _discoverIsLoading;

  bool get discoverRetry => _discoverRetry;
  bool _retry = false;
  bool _foodsRetry = false;
  bool _discoverRetry = false;
  bool _areaStatus = false;
  bool get isLoading => _isLoading;
  bool get foodsIsLoading => _foodsIsLoading;
  var _bannersList = [];
  bool get areaStatus => _areaStatus;

  get bannersList => _bannersList;

  bool get retry => _retry;
  bool get foodsRetry => _foodsRetry;
  bool visible = true;
  int _selectedOrderType = 0;

  int get selectedOrderType => _selectedOrderType;

  set setOrderType(int value) {
    _selectedOrderType = value;
    notifyListeners();
  }

  List<CategoryData> _categoryData = [];
  Products? _productsList;
  List<DiscoverItem> _discoverList = [];

  Products get productsList => _productsList!;

  List<DiscoverItem> get discoverList => _discoverList;

  List<CategoryData> get categoryData => _categoryData;

  Future<void> getData() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _categoryData = DummyData().categoryData;
      _isLoading = false;
    });
    notifyListeners();
  }

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverList.clear();
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getFoodsPageData() async {
    _foodsRetry = false;
    _foodsIsLoading = true;
    try {
      await Future.wait([getDiscoverList(), getBanners(), _getProducts("1")]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;

    notifyListeners();
  }

  Future<void> getDiscoverList() async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    await Future.delayed(Duration(milliseconds: 1500), () {
      _discoverList = DummyData().discoverList;
    });
    _discoverIsLoading = false;

    notifyListeners();
  }

  Future<void> getBanners() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _bannersList = DummyData().banners;
    });
  }

  // get Products
  Future<void> _getProducts(String id) async {
    try {
      _productsList = await ProductsRepository().getProductsList(id);
    } catch (e) {
      print(e.toString());
    }
  }
}
