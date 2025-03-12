import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/widget/home/product_card.dart';

class ProductCardView extends StatelessWidget {
  final List<Products> productList;

  const ProductCardView({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1.5;

    return SizedBox(
      height: 330,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Container(
            width: itemWidth,
            child: ProductsCard(product: productList[index]),
          );
        },
      ),
    );
  }
}
