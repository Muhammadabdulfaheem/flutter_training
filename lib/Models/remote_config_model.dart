class RemoteConfigModel {
  final String baseURL;
  final String apiKey;
  final String imagesURL;
  final String searchMovie;
  final String upcomingMovie;
  final String nowPlayingMovie;
  final String platziBaseURL;

  RemoteConfigModel({
    required this.searchMovie,
    required this.upcomingMovie,
    required this.nowPlayingMovie,
    required this.platziBaseURL,
    required this.baseURL,
    required this.apiKey,
    required this.imagesURL,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigModel(
      baseURL: json['baseURL'],
      apiKey: json['apiKey'],
      imagesURL: json['imagesURL'],
      searchMovie: json["searchMovie"],
      upcomingMovie: json["upcomingMoviesEndpoint"],
      nowPlayingMovie: json["moviesNowPlayingEndPoint"],
      platziBaseURL: json["platziBaseURL"],
    );
  }

  Map<String, dynamic> toJson() => {
    "baseURL": baseURL,
    "apiKey": apiKey,
    "imagesURL": imagesURL,
    "searchMovie": searchMovie,
    "upcomingMoviesEndpoint": upcomingMovie,
    "moviesNowPlayingEndPoint": nowPlayingMovie,
    "platziBaseURL": platziBaseURL,
  };
}
