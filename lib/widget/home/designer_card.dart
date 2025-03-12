import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/widget/home/custom_cache_image.dart';

class DesignerCard extends StatelessWidget {
  final List<Products> designerList;

  const DesignerCard({super.key, required this.designerList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: designerList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedImageWidget(
                imageUrl: designerList[index].imageUrl,
                fit: BoxFit.cover,
                width: 72,
                height: 72,
              ),
            ),
          );
        },
      ),
    );
  }
}
