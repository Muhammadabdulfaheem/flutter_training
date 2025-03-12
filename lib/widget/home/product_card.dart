import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/routing/routes_names.dart';
import 'package:flutter_training_project/utils/constants/app_colors.dart';
import 'package:flutter_training_project/widget/home/custom_cache_image.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';
import 'package:go_router/go_router.dart';

class ProductsCard extends StatelessWidget {
  final Products product;
  const ProductsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    double rightPadding = locale.countryCode == 'en' ? 100 : 10;

    return GestureDetector(
      onTap: () {
        context.push(RoutesNames.productDetails, extra: product);
      },
      child: Card(
        color: AppColors.primaryColor,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Container(
                height: 220,
                width: double.infinity,
                child: CachedImageWidget(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  width: 220,
                  height: 220,
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 10,
                bottom: 0,
                right: rightPadding,
              ),
              child: LocalizedText(
                product.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
