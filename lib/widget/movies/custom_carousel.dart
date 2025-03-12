import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/tv_series.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';
import 'package:flutter_training_project/widget/movies/landing_card.dart';

class CustomCarouselSlider extends StatelessWidget {
  late TvSeries topRatedSeries;

  CustomCarouselSlider({super.key, required this.topRatedSeries});

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfigService();
    var size = MediaQuery.of(context).size;
    var carouselOptions = carousel.CarouselOptions(
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      aspectRatio: 16 / 9,
      viewportFraction: 0.9,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: carousel.CarouselSlider.builder(
        itemCount: topRatedSeries.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = topRatedSeries.results[index].backdropPath.toString();
          return GestureDetector(
            onTap: () {},
            child: LandingCard(
              image: CachedNetworkImageProvider("${appConfig.imagesURL}$url"),
              name: topRatedSeries.results[index].name.toString(),
            ),
          );
        },
        options: carouselOptions,
      ),
    );
  }
}
