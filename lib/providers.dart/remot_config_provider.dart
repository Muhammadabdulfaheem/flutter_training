import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/Models/remote_config_model.dart';
import 'package:get_storage/get_storage.dart';

class RemotConfigProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<Products> _productList = [];
  List<Products> _designerList = [];
  List<Products> _categoriesList = [];

  bool get isLoading => _isLoading;
  List<Products> get productList => _productList;
  List<Products> get designerList => _designerList;
  List<Products> get categoriesList => _categoriesList;

  final _storage = GetStorage();
  RemoteConfigModel? _config;
  RemoteConfigModel? get config => _config;

  Future<void> fetchRemoteConfigData() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      // Set up Remote Config settings
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 5),
          minimumFetchInterval: Duration.zero, // Always fetch fresh data
        ),
      );

      // Fetch and activate the Remote Config values
      await remoteConfig.fetchAndActivate();
      String productListString = remoteConfig.getString("products");
      String designerListString = remoteConfig.getString("designers");
      String categoriesListString = remoteConfig.getString("categories");
      String appConstantString = remoteConfig.getString("appConstants");

      List<dynamic> productList = json.decode(productListString);
      List<dynamic> designerList = json.decode(designerListString);
      List<dynamic> categoriesList = json.decode(categoriesListString);

      Map<String, dynamic> jsonMap = json.decode(appConstantString);
      _config = RemoteConfigModel.fromJson(jsonMap);
      _storage.write("app_config", _config!.toJson());

      _productList =
          productList.map((item) => Products.fromJson(item)).toList();
      _designerList =
          designerList.map((item) => Products.fromJson(item)).toList();
      _categoriesList =
          categoriesList.map((item) => Products.fromJson(item)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching remote config: $e");
      _isLoading = false;
      _loadConfigFromLocal();
      notifyListeners();
    }
  }

  void _loadConfigFromLocal() {
    final data = _storage.read("app_config");
    if (data != null) {
      _config = RemoteConfigModel.fromJson(Map<String, dynamic>.from(data));
    }
  }
}
