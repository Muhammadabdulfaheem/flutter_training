const String CollectionsQuery = '''
 query CollectionsQuery {
  products(first: 10) {
    edges {
      cursor
      productDetails: node {
        availableForSale
        createdAt
        description
        descriptionHtml
        encodedVariantAvailability
        encodedVariantExistence
        handle
        id
        isGiftCard
        onlineStoreUrl
        productType
        publishedAt
        requiresSellingPlan
        tags
        title
        totalInventory
        trackingParameters
        updatedAt
        vendor
        relatedCollections: collections(first: 10) {
          totalCount
          edges {
            collectionInfo: node {
              image {
                src
                url
                width
                altText
              }
            }
          }
        }
      }
    }
  }
}

''';
