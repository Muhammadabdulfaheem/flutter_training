import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_training_project/networking/base_api_client.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';

class ApiServices {
  final BaseApiClient _apiClient;
  ApiServices(this._apiClient);

  final config = AppConfigService();

  Future<Response> fetchUpcomingMoviesData() {
    return _apiClient.get("${config.upcomingMovies}${config.apiKey}");
  }

  Future<Response> fetchNowPlayingMoviesData() {
    return _apiClient.get("${config.moviesNowPlaying}${config.apiKey}");
  }

  Future<Response> getSearchedMovie(String searchText) {
    return _apiClient.get(
      "${config.searchMovie}${config.apiKey}&query=${searchText}",
    );
  }

  Future<Response?> uploadFile(Uint8List bytes, String fileName) {
    return _apiClient.uploadImageFromBytes(bytes, fileName);
  }
}
