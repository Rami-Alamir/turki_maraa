import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/repository/home_repository.dart';
import 'package:new_turki/repository/products_repository.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _canPickup = true;
  bool _isLoading = true;
  bool _productIsLoading = true;
  bool _productIsRetry = false;
  bool _foodsIsLoading = true;
  bool _discoverIsLoading = true;
  BitmapDescriptor? _myMarker;
  LatLng? _latLng;
  bool? _initMap = false;
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  int _selectedShalwata = -1;

  bool get productIsRetry => _productIsRetry;

  bool get productIsLoading => _productIsLoading;

  int get selectedSize => _selectedSize;

  bool get canPickup => _canPickup;

  bool get initMap => _initMap!;

  set initMap(bool value) {
    _initMap = value;
  }

  LatLng get latLng => _latLng ?? LatLng(0, 0);

  set latLng(LatLng value) {
    _latLng = value;
    print(value.toString());
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    _retry = false;
    notifyListeners();
  }

  BitmapDescriptor get myMarker => _myMarker!;

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

  CategoryData? _categoryData;
  Products? _productsList;
  Product? _productData;

  Product get productData => _productData!;
  List<DiscoverItem> _discoverList = [];

  Products get productsList => _productsList!;

  List<DiscoverItem> get discoverList => _discoverList;

  CategoryData get categoryData => _categoryData!;

  Future<void> getData() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    _isLoading = true;
    _retry = false;
    try {
      _categoryData = await HomeRepository().getCategoriesList();
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverList.clear();
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getFoodsPageData(int id, {bool isLoading = true}) async {
    _foodsRetry = false;
    _foodsIsLoading = isLoading;
    try {
      await Future.wait([getDiscoverList(), getBanners(), _getProducts("$id")]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;

    notifyListeners();
  }

  Future<void> getDiscoverList() async {
    _discoverIsLoading = true;
    _discoverRetry = false;
    await Future.delayed(Duration(milliseconds: 500), () {
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
      print(e.toString() + "rami");
    }
  }

  // get Product
  Future<void> getProductData(String id) async {
    _productIsLoading = true;
    try {
      _productData = await ProductsRepository().getProduct(id);
    } catch (e) {
      print(e.toString() + "rami");
      _productIsRetry = true;
    }
    _productIsLoading = false;
    notifyListeners();
  }

  //get user location + init marker
  void initMapData() async {
    print('initMapData');
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(25, 25)), 'assets/images/pin.png')
        .then((onValue) {
      _myMarker = onValue;
      notifyListeners();
    });
    LocationData _locationData = await Location().getLocation();
    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  //for test
  List<String> address = ["الموقع الحالي", "الياسمين", "العمل", "المنزل"];
  int selectedAddress = 0;
  List<String> address2 = [
    "ملحمة الياسمين",
    "ملحمة المونسية",
  ];
  int selectedAddress2 = 0;

  int get selectedPackaging => _selectedPackaging;

  int get selectedChopping => _selectedChopping;

  int get selectedShalwata => _selectedShalwata;

  set setSelectedShalwata(int value) {
    _selectedShalwata = value;
    notifyListeners();
  }

  set setSelectedChopping(int value) {
    _selectedChopping = value;
    notifyListeners();
  }

  set setProductIsLoading(bool value) {
    _productIsLoading = value;
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

  void initExtras() {
    _selectedSize = -1;
    _selectedChopping = -1;
    _selectedPackaging = -1;
    _selectedShalwata = -1;
  }

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
    if (_selectedShalwata >= 0)
      price += double.parse(_productData!.data!.shalwata!.price!);
    return price;
  }
}
