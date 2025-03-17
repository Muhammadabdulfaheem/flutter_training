import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/graphql/graphql_service.dart';
import 'package:flutter_training_project/graphql/product_state.dart';
import 'package:flutter_training_project/graphql/queries/collection_query.dart';

class ProductCollectionCubit extends Cubit<ProductState> {
  final GraphQLService _graphQLService;

  ProductCollectionCubit(this._graphQLService) : super(ProductInitalState());

  Future<void> fetchCollections() async {
    emit(ProductLoading());

    try {
      final result = await _graphQLService.performQuery(CollectionsQuery);

      if (result.hasException) {
        emit(ProductError(errorMessage: result.hasException.toString()));
        print("GraphQL Error: ${result.exception}");
        return;
      }

      final data = result.data;
      final products = data?['products']?['edges'] ?? [];

      List<Map<String, dynamic>> formattedProducts = [];

      for (var productEdge in products) {
        final product = productEdge['productDetails'];
        print('Product title: ${product['title']}');

        final collections = product['relatedCollections']['edges'];
        for (var collection in collections) {
          final collectionData = collection['collectionInfo'];
          final image = collectionData['image'];
          print(
            ' GraphQL  Collection Image: ${image?['url']} | Alt Text: ${image?['altText']}',
          );
        }

        formattedProducts.add(product);
      }

      emit(ProductSuccess(products: formattedProducts));
    } catch (e) {
      emit(ProductError(errorMessage: e.toString()));
      print("Exception caught: $e");
    }
  }
}
