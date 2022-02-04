import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_turki/models/banners_data.dart';
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/repository/home_repository.dart';
import 'package:new_turki/repository/products_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class HomeProvider with ChangeNotifier {
  bool _canPickup = true;
  bool _isLoading = true;
  bool _productIsLoading = true;
  bool _productIsRetry = false;
  bool _foodsIsLoading = true;
  bool _discoverIsLoading = true;
  int _selectedSize = -1;
  int _selectedPackaging = -1;
  int _selectedChopping = -1;
  bool _selectedShalwata = false;
  bool _retry = false;
  bool _foodsRetry = false;
  bool _discoverRetry = false;
  bool _areaStatus = false;
  var _bannersList = [];
  bool visible = true;
  int _selectedOrderType = 0;
  CategoryData? _categoryData;
  BestSeller? _bestSeller;
  BannersData? _bannersData;
  Products? _productsList;
  Product? _productData;
  DiscoverItem? _discoverData;
  int _selectedAddress2 = 0;
  bool _isFavourite = false;

  BestSeller? get bestSeller => _bestSeller;
  BannersData? get bannersData => _bannersData;
  bool get isFavourite => _isFavourite;
  bool get productIsRetry => _productIsRetry;
  bool get productIsLoading => _productIsLoading;
  int get selectedSize => _selectedSize;
  bool get canPickup => _canPickup;
  bool get discoverIsLoading => _discoverIsLoading;
  bool get discoverRetry => _discoverRetry;
  bool get isLoading => _isLoading;
  bool get foodsIsLoading => _foodsIsLoading;
  bool get areaStatus => _areaStatus;
  get bannersList => _bannersList;
  bool get retry => _retry;
  bool get foodsRetry => _foodsRetry;
  int get selectedOrderType => _selectedOrderType;
  Product get productData => _productData!;
  Products get productsList => _productsList!;
  DiscoverItem? get discoverData => _discoverData;
  CategoryData get categoryData => _categoryData!;
  int get selectedAddress2 => _selectedAddress2;
  int get selectedPackaging => _selectedPackaging;
  int get selectedChopping => _selectedChopping;
  bool get selectedShalwata => _selectedShalwata;

  set setIsLoading(bool value) {
    _isLoading = value;
    _retry = false;
    notifyListeners();
  }

  set setOrderType(int value) {
    _selectedOrderType = value;
    notifyListeners();
  }

  set setSelectedAddress2(int value) {
    _selectedAddress2 = value;
  }

  set setSelectedShalwata(bool value) {
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

  set setIsFavourite(bool value) {
    _isFavourite = value;
  }

  set setIsFavourite2(bool value) {
    _isFavourite = value;
    notifyListeners();
  }

  //get all categories
  Future<void> getCategories() async {
    try {
      _categoryData = await HomeRepository().getCategoriesList();
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
  }

  //get Best Seller
  Future<void> getBestSeller() async {
    try {
      _bestSeller = await ProductsRepository().getBestSeller();
    } catch (e) {
      print(e.toString());
      _retry = true;
    }
  }

  void disposeFood() {
    _foodsIsLoading = true;
    _discoverData = null;
    _bannersList.clear();
    _foodsRetry = false;
  }

  Future<void> getHomePageData({bool isLoading = true}) async {
    _retry = false;
    _isLoading = isLoading;
    try {
      await Future.wait([getCategories(), getBestSeller()]);
    } catch (e) {
      _retry = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getFoodsPageData(int id, {bool isLoading = true}) async {
    _foodsRetry = false;
    _foodsIsLoading = isLoading;
    try {
      await Future.wait(
          [getDiscoverList(id), getBanners(id), _getProducts("$id")]);
    } catch (e) {
      _foodsRetry = true;
    }
    _foodsIsLoading = false;
    notifyListeners();
  }

  Future<void> getDiscoverList(int categoryId) async {
    _discoverData = null;
    try {
      _discoverData = await HomeRepository().getDiscover(categoryId);
    } catch (e) {
      print(e.toString());
      //  _foodsRetry = true;
    }
  }

  Future<void> getBanners(int categoryId) async {
    try {
      _bannersData = await HomeRepository().getBannersList(categoryId);
    } catch (e) {
      print(e.toString());
      _foodsRetry = true;
    }
  }

  // get Products
  Future<void> _getProducts(String id) async {
    try {
      _productsList = await ProductsRepository().getProductsList(id);
    } catch (e) {
      _foodsRetry = true;
      print(e.toString() + "rami");
    }
  }

  // get Product details
  Future<void> getProductData(String id) async {
    _productIsLoading = true;
    _productIsRetry = false;
    try {
      _productData = await ProductsRepository().getProduct(id);
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
