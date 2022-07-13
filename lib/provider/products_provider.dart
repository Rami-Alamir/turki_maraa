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
  bool _productsHomeIsLoading = true;
  bool _discoverIsLoading = true;
  int _selectedDay = -1;
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  bool _selectedShalwata = false;
  bool _productsHomeRetry = false;
  bool _withoutTrotters = false;
  bool _withoutHead = false;
  bool _withoutTailFat = false;
  bool _withoutTripe = false;
  bool _discoverRetry = false;
  var _bannersList = [];
  BannersData? _bannersData;
  Products? _productsList;
  Product? _productData;
  DiscoverData? _discoverData;
  bool _isFavourite = false;
  DiscoverItem.DiscoverItem? _discoverItem;
  List<Extra> _days = [
    Extra(nameAr: 'اليوم الأول', nameEn: 'First day'),
    Extra(nameAr: 'اليوم الثاني', nameEn: 'Second day'),
    Extra(nameAr: 'اليوم الثالث', nameEn: 'Third day'),
    Extra(nameAr: 'اليوم الرابع', nameEn: 'Fourth day'),
  ];

  List<Extra> get days => _days;

  BannersData? get bannersData => _bannersData;
  bool get isFavourite => _isFavourite;
  bool get productIsRetry => _productIsRetry;
  bool get productIsLoading => _productIsLoading;
  int get selectedDay => _selectedDay;
  int get selectedSize => _selectedSize;
  bool get discoverIsLoading => _discoverIsLoading;
  bool get discoverRetry => _discoverRetry;
  bool get productsHomeIsLoading => _productsHomeIsLoading;
  get bannersList => _bannersList;
  bool get productsHomeRetry => _productsHomeRetry;
  Product get productData => _productData!;
  Products get productsList => _productsList!;
  DiscoverData? get discoverData => _discoverData;
  int get selectedPackaging => _selectedPackaging;
  int get selectedChopping => _selectedChopping;
  bool get selectedShalwata => _selectedShalwata;
  DiscoverItem.DiscoverItem get discoverItem => _discoverItem!;

  bool get withoutHead => _withoutHead;
  bool get withoutTailFat => _withoutTailFat;
  bool get withoutTripe => _withoutTripe;
  bool get withoutTrotters => _withoutTrotters;

  set withoutTrotters(bool value) {
    _withoutTrotters = value;
    notifyListeners();
  }

  set withoutHead(bool value) {
    _withoutHead = value;
    notifyListeners();
  }

  set withoutTailFat(bool value) {
    _withoutTailFat = value;
    notifyListeners();
  }

  set withoutTripe(bool value) {
    _withoutTripe = value;
    notifyListeners();
  }

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

  set setSelectedDay(int value) {
    _selectedDay = value;
    if (value == 0) {
      _selectedChopping = -1;
      _selectedPackaging = -1;
    }
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
    _productsHomeIsLoading = true;
    _discoverData = null;
    _bannersList.clear();
    _productsHomeRetry = false;
  }

  Future<void> getProductsHomePageData(int id, LatLng latLng, String countryId,
      {bool isLoading = true}) async {
    _productsHomeRetry = false;
    _productsHomeIsLoading = isLoading;
    try {
      await Future.wait([
        getDiscoverList(id, latLng, countryId),
        getBanners(id, latLng, countryId),
        _getProducts("$id", latLng, countryId),
      ]);
    } catch (e) {
      _productsHomeRetry = true;
    }
    _productsHomeIsLoading = false;
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
      _productsHomeRetry = true;
    }
  }

  // get Products
  Future<void> _getProducts(String id, LatLng latLng, String countryId) async {
    try {
      _productsList =
          await ProductsRepository().getProductsList(id, latLng, countryId);
    } catch (e) {
      _productsHomeRetry = true;
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
      if (_productData!.data!.sizes!.length == 1) _selectedSize = 0;
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
    _selectedDay = -1;
    _selectedPackaging = -1;
    _withoutHead = false;
    _withoutTrotters = false;
    _withoutTripe = false;
    _withoutTailFat = false;
    _selectedShalwata = false;
  }

  //get discover item Data
  Future<void> getDiscoverItem(int id, LatLng latLng, String countryId) async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    try {
      _discoverItem =
          await HomeRepository().getDiscoverItem(id, latLng, countryId);
    } catch (e) {
      print('catch _discoverItem');
      print(e.toString());
      _discoverRetry = true;
    }
    _discoverIsLoading = false;
    notifyListeners();
  }

  // used in product details
  String getProductWeight() {
    String weight = _productData!.data!.weight!;
    if (_selectedSize >=
        0) if (_productData!.data!.sizes![_selectedSize].weight!.length > 0)
      weight = _productData!.data!.sizes![_selectedSize].weight!;
    return weight;
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
