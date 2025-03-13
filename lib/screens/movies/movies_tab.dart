import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/screens/movies/bloc/fileUploading/file_uploading_cubit.dart';
import 'package:flutter_training_project/screens/movies/bloc/fileUploading/movie_file_uploading_state.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies/movies_cubit.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies/movies_state.dart';
import 'package:flutter_training_project/utils/constants/file_pickers.dart';
import 'package:flutter_training_project/widget/movies/upcoming_movie.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocListener<FileUploadingCubit, MovieFileUploadingState>(
              listener: (context, state) {
                if (state is FileUpoadingSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("File uploaded successfully!")),
                  );
                } else if (state is FileUpoadingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Upload failed: ${state.errorMesssge}"),
                    ),
                  );
                }
              },
              child: BlocConsumer<MoviesCubit, MoviesState>(
                listener: (context, state) {
                  if (state is MoviesSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Movies fetched successfully")),
                    );
                  } else if (state is MoviesErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Getting error while fetching movies"),
                      ),
                    );
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
                          ElevatedButton(
                            onPressed: () async {
                              File? pickedImage =
                                  await FilePickers().pickImageFromGallery();
                              if (pickedImage != null) {
                                Uint8List bytes =
                                    await pickedImage.readAsBytes();
                                context
                                    .read<FileUploadingCubit>()
                                    .fileUploading(bytes, "file.jpg");
                              }
                            },
                            child: Text("Upload Image"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MoviesErrorState) {
                    return Center(child: Text(state.errorMessage));
                  }
                  return const Center(
                    child: Text("Loading upcoming movies..."),
                  );
                },
              ),
            ),

            BlocBuilder<FileUploadingCubit, MovieFileUploadingState>(
              builder: (context, state) {
                if (state is FileLoading) {
                  return Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
