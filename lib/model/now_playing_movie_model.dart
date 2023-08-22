class NowPlayingMovieModel {
  final int id;
  final String posterpath;
  final String backdropPath;

  NowPlayingMovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        posterpath = "https://image.tmdb.org/t/p/w500${json['poster_path']}",
        backdropPath = "https://image.tmdb.org/t/p/w500${json['backdrp_path']}";
}
