import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetails extends StatelessWidget {
  final Products product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name.tr(),
          style: Theme.of(context).textTheme.labelMedium,
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    LocalizedText(
                      product.name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: 15),
                    LocalizedText(
                      'productDesc',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),

              // Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
