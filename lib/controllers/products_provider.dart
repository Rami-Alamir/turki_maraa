import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/banners_data.dart';
import '../models/discover_data.dart';
import '../models/product.dart';
import '../repository/home_repository.dart';
import '../repository/products_repository.dart';

class ProductsProvider with ChangeNotifier {
  RequestStatus _requestStatus = RequestStatus.isLoading;
  final _bannersList = [];
  BannersData? _bannersData;
  Product? _productsList;
  DiscoverData? _discoverData;
  LatLng? _latLng;
  String? _isoCountryCode;
  BannersData? get bannersData => _bannersData;
  get bannersList => _bannersList;
  Product get productsList => _productsList!;
  DiscoverData? get discoverData => _discoverData;
  RequestStatus get requestStatus => _requestStatus;

  void disposeFood() {
    _discoverData = null;
    _bannersList.clear();
  }

  Future<void> getFoodsPageData(int id, {bool isLoading = true}) async {
    _requestStatus = RequestStatus.isLoading;
    try {
      await Future.wait([
        _getDiscoverList(id),
        _getBanners(id),
        _getProducts("$id"),
      ]);
      _requestStatus = RequestStatus.completed;
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
    notifyListeners();
  }

  Future<void> _getDiscoverList(int categoryId) async {
    _discoverData = null;
    try {
      _discoverData = await sl<HomeRepository>()
          .getDiscover(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {}
  }

  Future<void> _getBanners(int categoryId) async {
    try {
      _bannersData = await sl<HomeRepository>()
          .getBannersList(categoryId, _latLng!, _isoCountryCode!);
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
  }

  Future<void> _getProducts(String id) async {
    try {
      _productsList = await sl<ProductsRepository>()
          .getProductsList(id, _latLng!, _isoCountryCode!);
    } catch (_) {
      _requestStatus = RequestStatus.error;
    }
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
