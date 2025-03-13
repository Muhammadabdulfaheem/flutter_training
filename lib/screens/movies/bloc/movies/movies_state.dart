import 'package:flutter_training_project/Models/upcoming_movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesSuccessState extends MoviesState {
  final UpComingMovieModels upcomingMovies;
  final UpComingMovieModels nowPlayingMovies;
  MoviesSuccessState({
    required this.upcomingMovies,
    required this.nowPlayingMovies,
  });
}

class MoviesErrorState extends MoviesState {
  final String errorMessage;
  MoviesErrorState({required this.errorMessage});
}
