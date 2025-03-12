import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies_cubit.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies_state.dart';
import 'package:flutter_training_project/widget/movies/upcoming_movie.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesCubit>();
    if (cubit.state is MoviesInitial) {
      cubit.fetchMovies();
    }
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MoviesCubit, MoviesState>(
          listener: (context, state) {
            if (state is MoviesSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Movies fetched successfully")),
              );

              if (state is MoviesErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Getting error while fetcing the movies"),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MoviesSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    MovieHorizontalList(
                      title: "Upcoming Movies",
                      movies: state.upcomingMovies.results,
                    ),
                    MovieHorizontalList(
                      title: "Now Playing Movies",
                      movies: state.nowPlayingMovies.results,
                    ),
                  ],
                ),
              );
            } else if (state is MoviesErrorState) {
              Center(child: Text(state.errorMessage));
            }
            return const Center(child: Text("Loading upcoming movies..."));
          },
        ),
      ),
    );
    /*
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
      */
  }
}
