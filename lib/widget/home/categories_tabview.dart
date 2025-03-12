import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/utils/constants/app_colors.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';

class CategoriesTabView extends StatelessWidget {
  final List<Products> categories;

  const CategoriesTabView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border:
                        index == 0
                            ? Border.all(color: AppColors.textColor, width: 1)
                            : Border.all(
                              color: AppColors.secondaryColor,
                              width: 1,
                            ),

                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: LocalizedText(
                      categories[index].name,
                      style: Theme.of(
                        context,
                      ).primaryTextTheme.bodyMedium?.copyWith(
                        color:
                            index == 0
                                ? AppColors.textColor
                                : AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
