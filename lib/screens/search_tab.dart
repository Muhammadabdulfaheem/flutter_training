import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_project/providers.dart/home_api_provider.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';
import 'package:flutter_training_project/widget/home/custom_cache_image.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final appConfig = AppConfigService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: Consumer<HomeApiProvider>(
      //     builder: (context, provider, _) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           children: [
      //             CupertinoSearchTextField(
      //               controller: searchController,
      //               prefixIcon: Icon(Icons.search),
      //               onChanged: (value) {
      //                 if (value.trim().isNotEmpty) {
      //                   provider.getSearchedMovie(value.trim());
      //                 }
      //               },
      //             ),
      //             const SizedBox(height: 16),
      //             if (provider.isSearchedMovie)
      //               const CircularProgressIndicator()
      //             else if (provider.searchedMovies != null &&
      //                 searchController.text.isNotEmpty)
      //               Expanded(
      //                 child: ListView.builder(
      //                   itemCount: provider.searchedMovies?.results.length,
      //                   itemBuilder: (context, index) {
      //                     final movie = provider.searchedMovies!.results[index];
      //                     return Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: ListTile(
      //                         leading: CachedImageWidget(
      //                           imageUrl:
      //                               "${appConfig.imagesURL}${movie.backdropPath}",
      //                           width: 150,
      //                           height: 150,
      //                           fit: BoxFit.cover,
      //                         ),
      //                         title: Text(movie.title),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               )
      //             else if (provider.searchedMovieErrorMessage.isNotEmpty)
      //               Text(provider.searchedMovieErrorMessage),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
