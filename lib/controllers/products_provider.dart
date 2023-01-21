import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/service/service_locator.dart';
import '../models/banners_data.dart';
import '../models/discover_data.dart';
import '../models/discover_item.dart' as discover_item;
import '../models/product.dart';
import '../repository/home_repository.dart';
import '../repository/products_repository.dart';

class ProductsProvider with ChangeNotifier {
  bool _foodsIsLoading = true;
  bool _discoverIsLoading = true;
  bool _foodsRetry = false;
  bool _discoverRetry = false;
  final _bannersList = [];
  BannersData? _bannersData;
  Product? _productsList;
  DiscoverData? _discoverData;
  discover_item.DiscoverItem? _discoverItem;
  LatLng? _latLng;
  String? _isoCountryCode;
  BannersData? get bannersData => _bannersData;
  bool get discoverIsLoading => _discoverIsLoading;
  bool get discoverRetry => _discoverRetry;
  bool get foodsIsLoading => _foodsIsLoading;
  get bannersList => _bannersList;
  bool get foodsRetry => _foodsRetry;
  Product get productsList => _productsList!;
  DiscoverData? get discoverData => _discoverData;
  discover_item.DiscoverItem get discoverItem => _discoverItem!;

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverData = null;
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getFoodsPageData(int id, {bool isLoading = true}) async {
    _foodsRetry = false;
    _foodsIsLoading = isLoading;
    try {
      await Future.wait([
        _getDiscoverList(id),
        _getBanners(id),
        _getProducts("$id"),
      ]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;
    notifyListeners();
  }

  Future<void> _getDiscoverList(int categoryId) async {
    _discoverData = null;
    try {
      _discoverData = await sl<HomeRepository>()
          .getDiscover(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {
      //  _foodsRetry = true;
    }
  }

  Future<void> _getBanners(int categoryId) async {
    try {
      _bannersData = await sl<HomeRepository>()
          .getBannersList(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {
      _foodsRetry = true;
    }
  }

  // get Products
  Future<void> _getProducts(String id) async {
    try {
      _productsList = await sl<ProductsRepository>()
          .getProductsList(id, _latLng!, _isoCountryCode!);
    } catch (_) {
      _foodsRetry = true;
    }
  }

  //get discover item Data
  Future<void> getDiscoverItem(int id) async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    try {
      _discoverItem = await sl<HomeRepository>()
          .getDiscoverItem(id, _latLng!, _isoCountryCode!);
    } catch (_) {
      _discoverRetry = true;
    }
    _discoverIsLoading = false;
    notifyListeners();
  }

  // update location data
  Future<void> updateLocation(
    LatLng? latLng,
    String? isoCountryCode,
  ) async {
    if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _isoCountryCode = isoCountryCode;
      }
    }
  }
}
