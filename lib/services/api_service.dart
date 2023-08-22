import 'dart:convert';

import 'package:flutter_movie_app/model/coming_soon_movie_model.dart';
import 'package:flutter_movie_app/model/moive_detail_model.dart';
import 'package:flutter_movie_app/model/now_playing_movie_model.dart';
import 'package:flutter_movie_app/model/popular_movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseURL = "https://movies-api.nomadcoders.workers.dev/";
  final String popular = "popular";
  final String now = "now-playing";
  final String soon = "coming-soon";
  final String movieid = "movie?id=";

  Future<List<PopularMovieModel>> getPoplularMovies() async {
    List<PopularMovieModel> movieList = [];
    final url = Uri.parse('$baseURL$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      final List<dynamic> movieRes = movies['results']!;
      for (var movie in movieRes) {
        movieList.add(PopularMovieModel.fromJson(movie));
      }
      return movieList;
    }
    throw Error();
  }

  Future<List<NowPlayingMovieModel>> getPlayingMovies() async {
    List<NowPlayingMovieModel> movieList = [];
    final url = Uri.parse('$baseURL$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      final List<dynamic> movieRes = movies['results']!;
      for (var movie in movieRes) {
        movieList.add(NowPlayingMovieModel.fromJson(movie));
      }
      return movieList;
    }
    throw Error();
  }

  Future<List<ComingSoonMovieModel>> getComingMovies() async {
    List<ComingSoonMovieModel> movieList = [];
    final url = Uri.parse('$baseURL$soon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      final List<dynamic> movieRes = movies['results']!;
      for (var movie in movieRes) {
        movieList.add(ComingSoonMovieModel.fromJson(movie));
      }
      return movieList;
    }
    throw Error();
  }

  Future<MovieDetailModel> getDetail(int id) async {
    final url = Uri.parse('$baseURL$movieid$id');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      print(movie);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
