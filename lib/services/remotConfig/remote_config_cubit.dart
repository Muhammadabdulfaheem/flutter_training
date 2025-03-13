import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/Models/remote_config_model.dart';
import 'package:flutter_training_project/services/remotConfig/remote_config_state.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_training_project/utils/constants/global_config.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  RemoteConfigCubit() : super(RemoteConfigInitial());

  Future<void> fetchRemoteConfigData() async {
    emit(RemoteConfigLoading());

    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 5),
          minimumFetchInterval: Duration.zero,
        ),
      );

      await remoteConfig.fetchAndActivate();

      final productListString = remoteConfig.getString("products");
      final designerListString = remoteConfig.getString("designers");
      final categoriesListString = remoteConfig.getString("categories");

      final productList =
          (json.decode(productListString) as List)
              .map((e) => Products.fromJson(e))
              .toList();
      final designerList =
          (json.decode(designerListString) as List)
              .map((e) => Products.fromJson(e))
              .toList();
      final categoriesList =
          (json.decode(categoriesListString) as List)
              .map((e) => Products.fromJson(e))
              .toList();

      final appConstantString = remoteConfig.getString("appConstants");
      final config = RemoteConfigModel.fromJson(json.decode(appConstantString));
      GlobalConfig.remoteConfig = config;

      emit(RemoteConfigSuccess(productList, designerList, categoriesList));
    } catch (e) {
      emit(RemoteConfigError(error: e.toString()));
    }
  }
}
