abstract class ProductState {}

class ProductInitalState extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<Map<String, dynamic>> products;

  ProductSuccess({required this.products});
}

class ProductError extends ProductState {
  final String errorMessage;

  ProductError({required this.errorMessage});
}
