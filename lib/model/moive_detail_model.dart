class MovieDetailModel {
  final String poster, title, rate, overview;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : poster = "https://image.tmdb.org/t/p/w500${json['poster_path']}",
        title = json['original_title'],
        rate = json['vote_average'].toString(),
        overview = json['overview'],
        genres = json['genres'];
}
