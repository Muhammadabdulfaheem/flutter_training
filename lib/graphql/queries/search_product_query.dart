const String searchProductsQuery = r'''
  query SearchProducts(
    $query: String!,
    $lang: String!,
    $productCount: Int!,
    $variantCount: Int!,
    $meta: [MetaInput!]!
  ) {
    searchProducts(
      query: $query,
      lang: $lang,
      productCount: $productCount,
      variantCount: $variantCount,
      meta: $meta
    ) {
      id
      title
      images {
        url
      }
      variants {
        id
        title
      }
      metafields {
        key
        value
      }
    }
  }
''';
