import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_training_project/Models/products.dart';
import 'package:flutter_training_project/Models/searched_movies_model.dart';
import 'package:flutter_training_project/Models/upcoming_movie.dart';
import 'package:flutter_training_project/networking/api_services.dart';
import 'package:flutter_training_project/networking/api_results.dart';
import 'package:flutter_training_project/networking/base_api_client.dart';
import 'package:flutter_training_project/utils/constants/app_config_helper.dart';

class HomeApiProvider extends ChangeNotifier {
  late ApiServices _apiServices;
  String? fileURL = "";

  ApiBaseType apiBaseType = ApiBaseType.tmdb;

  final APiStatus<UpComingMovieModels> upcomingMovies = APiStatus();
  final APiStatus<UpComingMovieModels> nowPlayingMovies = APiStatus();
  final APiStatus<SearchedMovies> searchedMovies = APiStatus();
  final APiStatus<ImagesData> imagesData = APiStatus();

  HomeApiProvider() {
    _initApiService();
    fetchAllData();
  }

  void _initApiService() {
    final appConfig = AppConfigService();
    final baseAPiClient = BaseApiClient(
      baseUrl:
          apiBaseType == ApiBaseType.tmdb
              ? appConfig.baseURL
              : appConfig.platziBaseURL,
    );
    _apiServices = ApiServices(baseAPiClient);
  }

  void swithcBaseURL(ApiBaseType type) {
    apiBaseType = type;
    _initApiService();
    notifyListeners();
  }

  // Fetch upcoming movies
  Future<void> fetchUpcomingMovies() async {
    upcomingMovies.isLoading = true;
    notifyListeners();

    try {
      final response = await _apiServices.fetchUpcomingMoviesData();
      if (response.data != null) {
        upcomingMovies.data = UpComingMovieModels.fromJson(response.data);
        upcomingMovies.error = "";
      } else {
        upcomingMovies.error = "No data received.";
      }
    } catch (e) {
      upcomingMovies.error = "Failed to load upcoming movies: $e";
      upcomingMovies.data = null;
    }

    upcomingMovies.isLoading = false;
    notifyListeners();
  }

  // Fetch now playing movies
  Future<void> fetchNowPlayingMovies() async {
    nowPlayingMovies.isLoading = true;
    notifyListeners();

    try {
      final response = await _apiServices.fetchNowPlayingMoviesData();
      if (response.data != null) {
        nowPlayingMovies.data = UpComingMovieModels.fromJson(response.data);
        nowPlayingMovies.error = "";
      } else {
        nowPlayingMovies.error = "No data received.";
      }
    } catch (e) {
      nowPlayingMovies.error = "Failed to load now playing movies: $e";
      nowPlayingMovies.data = null;
    }

    nowPlayingMovies.isLoading = false;
    notifyListeners();
  }

  Future<void> getSearchedMovie(String searchText) async {
    searchedMovies.isLoading = true;
    notifyListeners();

    try {
      final response = await _apiServices.getSearchedMovie(searchText);
      if (response.data != null) {
        searchedMovies.data = SearchedMovies.fromJson(response.data);
        searchedMovies.error = "";
      } else {
        searchedMovies.error = "No data received.";
      }
    } catch (e) {
      searchedMovies.error = "Failed to load top rated series: $e";
      searchedMovies.data = null;
    }

    searchedMovies.isLoading = false;
    notifyListeners();
  }

  Future<void> fileUpoad(Uint8List bytes, String fileName) async {
    imagesData.isLoading = true;
    notifyListeners();

    try {
      final response = await _apiServices.uploadFile(bytes, fileName);
      fileURL = response?.data['location'];
    } catch (e) {
      imagesData.error = "$e";
    }
    imagesData.isLoading = false;
    notifyListeners();
  }

  // A method to fetch all data at once
  Future<void> fetchAllData() async {
    await Future.wait([
      fetchUpcomingMovies(),
      fetchNowPlayingMovies(),
      // fetchTopRatedSerials(),
    ]);
  }
}

enum ApiBaseType { tmdb, platzi }

ApiBaseType apiBaseType = ApiBaseType.tmdb;

class ImagesDatas {
  final String originalname;
  final String filename;
  final String location;

  ImagesDatas({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  factory ImagesDatas.fromJson(Map<String, dynamic> json) {
    return ImagesDatas(
      originalname: json['originalname'] ?? '',
      filename: json['filename'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
