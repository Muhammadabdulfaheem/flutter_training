import 'package:get_storage/get_storage.dart';

class AppConfigService {
  late final String baseURL;
  late final String apiKey;
  late final String imagesURL;
  late final String upcomingMovies;
  late final String moviesNowPlaying;
  late final String searchMovie;
  late final String platziBaseURL;

  AppConfigService() {
    final config = GetStorage().read("app_config");
    baseURL = config?["baseURL"] ?? '';
    apiKey = config?["apiKey"] ?? '';
    imagesURL = config?["imagesURL"] ?? '';
    upcomingMovies = config?["upcomingMoviesEndpoint"] ?? '';
    moviesNowPlaying = config?["moviesNowPlayingEndPoint"] ?? '';
    searchMovie = config?["searchMovie"] ?? '';
    platziBaseURL = config?["platziBaseURL"] ?? '';
  }
}
