import 'package:flutter_training_project/Models/products.dart';

abstract class RemoteConfigState {}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigSuccess extends RemoteConfigState {
  final List<Products> productList;
  final List<Products> designerList;
  final List<Products> categoriesList;

  RemoteConfigSuccess(this.productList, this.designerList, this.categoriesList);
}

class RemoteConfigError extends RemoteConfigState {
  final String error;
  RemoteConfigError({required this.error});
}
