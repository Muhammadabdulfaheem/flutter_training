import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_training_project/providers.dart/home_api_provider.dart';
import 'package:flutter_training_project/utils/constants/file_pickers.dart';
import 'package:flutter_training_project/widget/movies/upcoming_movie.dart';
import 'package:provider/provider.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeApiProvider>(
          builder: (context, apiProvider, child) {
            bool isLoading =
                apiProvider.upcomingMovies.isLoading ||
                apiProvider.nowPlayingMovies.isLoading;

            String? errorMessage =
                apiProvider.upcomingMovies.error?.isNotEmpty ?? false
                    ? apiProvider.upcomingMovies.error
                    : apiProvider.nowPlayingMovies.error ?? "Faheem";

            if (isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (errorMessage!.isNotEmpty) {
              return Center(child: Text(errorMessage));
            } else if (apiProvider.upcomingMovies.data != null ||
                apiProvider.nowPlayingMovies.data != null)
              ;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieHorizontalList(
                        title: "Upcoming Movies",
                        movies: apiProvider.upcomingMovies.data?.results ?? [],
                      ),

                      MovieHorizontalList(
                        title: "Now Playing Movies",
                        movies:
                            apiProvider.nowPlayingMovies.data?.results ?? [],
                      ),

                      SizedBox(height: 20),

                      (apiProvider.imagesData.isLoading)
                          ? Center(child: CircularProgressIndicator())
                          : (Text(
                            apiProvider.fileURL?.isNotEmpty ?? false
                                ? "File Uploaded Successfully"
                                : "",
                          )),

                      ElevatedButton(
                        onPressed: () async {
                          File? pickedImage =
                              await FilePickers().pickImageFromGallery();

                          if (pickedImage != null) {
                            Uint8List bytes = await pickedImage.readAsBytes();
                            apiProvider.swithcBaseURL(ApiBaseType.platzi);
                            apiProvider.fileUpoad(bytes, "saved.jpg");
                          }
                        },
                        child: Text("Upload Image"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
