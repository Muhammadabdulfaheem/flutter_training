import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static const String _shopUrl =
      'https://379923-7e.myshopify.com/api/2024-10/graphql.json';
  static const String _accessToken = 'd885c1c7722a638ec9c2703288b0c90f';
  static const Duration _defaultTimeout = Duration(seconds: 30);

  final GraphQLClient client;

  GraphQLService()
    : client = GraphQLClient(
        link: HttpLink(
          _shopUrl,
          defaultHeaders: {
            'X-Shopify-Storefront-Access-Token': _accessToken,
            'Content-Type': 'application/json',
          },
        ),
        cache: GraphQLCache(),
        defaultPolicies: DefaultPolicies(
          query: Policies(
            cacheReread: CacheRereadPolicy.ignoreAll,
            fetch: FetchPolicy.cacheFirst,
          ),
        ),
      );

  Future<QueryResult> performQuery(String query) async {
    QueryOptions options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      pollInterval: _defaultTimeout,
    );

    late QueryResult result;
    try {
      result = await client.query(options);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<QueryResult> performQuery1(
    String query, {
    Map<String, dynamic>? variables,
  }) {
    final options = QueryOptions(
      document: gql(query),
      fetchPolicy: FetchPolicy.networkOnly,
      pollInterval: _defaultTimeout,
      variables: variables ?? {},
    );

    return client.query(options).catchError((e) {
      print('GraphQL Error: $e');
      throw e;
    });
  }
}
