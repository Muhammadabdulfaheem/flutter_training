import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/upcoming_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';

class MovieHorizontalList extends StatelessWidget {
  final String title;
  //final String errorMessage;
  final List<Result> movies;
  final double height;

  const MovieHorizontalList({
    super.key,
    required this.title,
    // required this.errorMessage,
    required this.movies,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    // If there is an error message, show the error
    final appConfig = AppConfigService();

    // if (errorMessage.isNotEmpty) {
    //   return Center(child: Text(errorMessage));
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: "${appConfig.imagesURL}${movie.backdropPath}",
                        fit: BoxFit.cover,
                        width: 300,
                        height: height,
                      ),
                      Positioned(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.6),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
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
