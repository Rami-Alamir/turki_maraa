import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/banners_data.dart';
import 'package:new_turki/models/discover_data.dart';
import 'package:new_turki/models/discover_item.dart' as DiscoverItem;
import 'package:new_turki/models/product.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/repository/home_repository.dart';
import 'package:new_turki/repository/products_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class ProductsProvider with ChangeNotifier {
  bool _productIsLoading = true;
  bool _productIsRetry = false;
  bool _foodsIsLoading = true;
  bool _discoverIsLoading = true;
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  bool _selectedShalwata = false;
  bool _foodsRetry = false;
  bool _discoverRetry = false;
  var _bannersList = [];
  BannersData? _bannersData;
  Products? _productsList;
  Product? _productData;
  DiscoverData? _discoverData;
  bool _isFavourite = false;
  DiscoverItem.DiscoverItem? _discoverItem;

  BannersData? get bannersData => _bannersData;
  bool get isFavourite => _isFavourite;
  bool get productIsRetry => _productIsRetry;
  bool get productIsLoading => _productIsLoading;
  int get selectedSize => _selectedSize;
  bool get discoverIsLoading => _discoverIsLoading;
  bool get discoverRetry => _discoverRetry;
  bool get foodsIsLoading => _foodsIsLoading;
  get bannersList => _bannersList;
  bool get foodsRetry => _foodsRetry;
  Product get productData => _productData!;
  Products get productsList => _productsList!;
  DiscoverData? get discoverData => _discoverData;
  int get selectedPackaging => _selectedPackaging;
  int get selectedChopping => _selectedChopping;
  bool get selectedShalwata => _selectedShalwata;
  DiscoverItem.DiscoverItem get discoverItem => _discoverItem!;

  set setProductIsLoading(bool value) {
    _productIsLoading = value;
    _productIsRetry = false;
    notifyListeners();
  }

  set setSelectedShalwata(bool value) {
    _selectedShalwata = value;
    notifyListeners();
  }

  set setSelectedChopping(int value) {
    _selectedChopping = value;
    notifyListeners();
  }

  set setSelectedPackaging(int value) {
    _selectedPackaging = value;
    notifyListeners();
  }

  set setSelectedSize(int value) {
    _selectedSize = value;
    notifyListeners();
  }

  set setIsFavourite(bool value) {
    _isFavourite = value;
  }

  set setIsFavourite2(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverData = null;
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getFoodsPageData(int id, LatLng latLng, String countryId,
      {bool isLoading = true}) async {
    _foodsRetry = false;
    _foodsIsLoading = isLoading;
    try {
      await Future.wait([
        getDiscoverList(id, latLng, countryId),
        getBanners(id, latLng, countryId),
        _getProducts("$id", latLng, countryId),
      ]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;
    notifyListeners();
  }

  Future<void> getDiscoverList(
      int categoryId, LatLng latLng, String countryId) async {
    _discoverData = null;
    try {
      _discoverData =
          await HomeRepository().getDiscover(categoryId, latLng, countryId);
    } catch (e) {
      print("getDiscoverList error");
      print(e.toString());
      //  _foodsRetry = true;
    }
  }

  Future<void> getBanners(
      int categoryId, LatLng latLng, String countryId) async {
    try {
      _bannersData =
          await HomeRepository().getBannersList(categoryId, latLng, countryId);
    } catch (e) {
      print(e.toString());
      print("getBanners");
      _foodsRetry = true;
    }
  }

  // get Products
  Future<void> _getProducts(String id, LatLng latLng, String countryId) async {
    try {
      _productsList =
          await ProductsRepository().getProductsList(id, latLng, countryId);
    } catch (e) {
      _foodsRetry = true;
      print("_getProducts");

      print(e.toString() + "rami");
    }
  }

  // get Product details
  Future<void> getProductData(
      String id, LatLng latLng, String countryId) async {
    _productIsLoading = true;
    _productIsRetry = false;
    try {
      _productData =
          await ProductsRepository().getProduct(id, latLng, countryId);
    } catch (e) {
      print(e.toString() + "rami");
      _productIsRetry = true;
    }
    _productIsLoading = false;
    notifyListeners();
  }

  // used in product details
  void initExtras() {
    _selectedSize = -1;
    _selectedChopping = -1;
    _selectedPackaging = -1;
    _selectedShalwata = false;
  }

  //get discover item Data
  Future<void> getDiscoverItem(int id) async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    try {
      print("d1");

      _discoverItem = await HomeRepository().getDiscoverItem(id);
      print("d2");
    } catch (e) {
      print('catch _discoverItem');
      print(e.toString());
      _discoverRetry = true;
    }
    _discoverIsLoading = false;
    notifyListeners();
  }

  // used in product details
  double getProductPrice() {
    double price = double.parse(_productData!.data!.price!);
    if (_selectedSize >= 0)
      price = double.parse(_productData!.data!.sizes![_selectedSize].price!);
    if (_selectedPackaging >= 0)
      price += double.parse(
          _productData!.data!.packaging![_selectedPackaging].price!);
    if (_selectedChopping >= 0)
      price +=
          double.parse(_productData!.data!.chopping![_selectedChopping].price!);
    if (_selectedShalwata)
      price += double.parse(_productData!.data!.shalwata!.price!);
    return price;
  }

  // used in product details
  double getProductSalePrice() {
    double price = double.parse(_productData!.data!.salePrice!);
    if (_selectedSize >= 0) if (double.parse(
            _productData!.data!.sizes![_selectedSize].salePrice!) >
        0)
      price =
          double.parse(_productData!.data!.sizes![_selectedSize].salePrice!);
    else
      price = double.parse(_productData!.data!.sizes![_selectedSize].price!);
    if (_selectedPackaging >= 0) if (double.parse(
            _productData!.data!.packaging![_selectedPackaging].salePrice!) >
        0)
      price += double.parse(
          _productData!.data!.packaging![_selectedPackaging].salePrice!);
    else
      price += double.parse(
          _productData!.data!.packaging![_selectedPackaging].price!);
    if (_selectedChopping >= 0) if (double.parse(
            _productData!.data!.chopping![_selectedChopping].salePrice!) >
        0)
      price += double.parse(
          _productData!.data!.chopping![_selectedChopping].salePrice!);
    else
      price +=
          double.parse(_productData!.data!.chopping![_selectedChopping].price!);
    if (_selectedShalwata)
      price += double.parse(_productData!.data!.shalwata!.price!);
    return price;
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }
}
