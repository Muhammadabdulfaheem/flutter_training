import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training_project/Models/upcoming_movie.dart';
import 'package:flutter_training_project/networking/api_services.dart';
import 'package:flutter_training_project/screens/movies/bloc/movies/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final ApiServices apiServices;

  MoviesCubit(this.apiServices) : super(MoviesInitial());

  Future<void> fetchMovies() async {
    emit(MoviesLoading());
    await Future.delayed(Duration(seconds: 1));
    try {
      final upcomingMoviesRes = await apiServices.fetchUpcomingMoviesData();
      final nowPlayingMoviesRes = await apiServices.fetchNowPlayingMoviesData();

      final upcomingMovies = UpComingMovieModels.fromJson(
        upcomingMoviesRes.data,
      );
      final nowPayingMovies = UpComingMovieModels.fromJson(
        nowPlayingMoviesRes.data,
      );

      emit(
        MoviesSuccessState(
          upcomingMovies: upcomingMovies,
          nowPlayingMovies: nowPayingMovies,
        ),
      );
    } catch (e) {
      emit(MoviesErrorState(errorMessage: e.toString()));
    }
  }
}
