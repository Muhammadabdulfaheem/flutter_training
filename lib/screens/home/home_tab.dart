import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/services/remotConfig/remote_config_cubit.dart';
import 'package:flutter_training_project/services/remotConfig/remote_config_state.dart';
import 'package:flutter_training_project/utils/constants/images_paths.dart';
import 'package:flutter_training_project/widget/home/categories_tabview.dart';
import 'package:flutter_training_project/widget/home/designer_card.dart';
import 'package:flutter_training_project/widget/home/home_header.dart';
import 'package:flutter_training_project/widget/home/localizaedText.dart';
import 'package:flutter_training_project/widget/home/product_cardview.dart';

class HomeTab extends StatelessWidget {
  final List<String> designersImages = [
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
  ];

  final List<String> imageUrls = [
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
    ImagesPaths.designerImagPath,
  ];

  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    double rightPadding = locale.languageCode == 'en' ? 0 : 20;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RemoteConfigCubit, RemoteConfigState>(
          listener: (context, state) {
            if (state is RemoteConfigSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Remote config data fetched successfully"),
                ),
              );
            } else if (state is RemoteConfigError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error.toString())));
            }
          },
          builder: (context, state) {
            if (state is RemoteConfigLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RemoteConfigSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: rightPadding,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      SizedBox(height: 20),
                      CategoriesTabView(categories: state.categoriesList),
                      SizedBox(height: 20),
                      ProductCardView(productList: state.productList),
                      SizedBox(height: 20),
                      LocalizedText(
                        'designerNearYou',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(height: 20),
                      DesignerCard(designerList: state.designerList),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        /*
        child: Consumer<RemotConfigProvider>(
          builder: (context, remotConfigProvider, child) {
            return remotConfigProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: rightPadding,
                      top: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(),
                        SizedBox(height: 20),
                        CategoriesTabView(
                          categories: remotConfigProvider.categoriesList,
                        ),
                        SizedBox(height: 20),
                        ProductCardView(
                          productList: remotConfigProvider.productList,
                        ),
                        SizedBox(height: 20),
                        LocalizedText(
                          'designerNearYou',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(height: 20),
                        DesignerCard(
                          designerList: remotConfigProvider.designerList,
                        ),
                      ],
                    ),
                  ),
                );
          },
        ),
        */
      ),
    );
  }
}
