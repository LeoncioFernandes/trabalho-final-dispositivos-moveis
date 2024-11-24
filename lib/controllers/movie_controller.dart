import 'package:dio/dio.dart';
import '../models/movie.dart';

class MovieController {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://206.42.23.7:59610'));

  Future<List<Movie>> getAllMovies() async {
    final response = await _dio.get('/movies');
    return (response.data['movies'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<List<Movie>> searchMovies(String title) async {
    final response = await _dio.get('/movies/$title');
    return (response.data['movies'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<Movie> getMovieById(int id) async {
    final response = await _dio.get('/movie/$id');
    return Movie.fromJson(response.data);
  }

  Future<void> updateMovie(int id, Movie movie) async {
    await _dio.put('/movie/$id', data: movie.toJson());
  }

  Future<void> deleteMovie(int id) async {
    await _dio.delete('/movie/$id');
  }

  Future<void> createMovie(Movie movie) async {
    await _dio.post('/movie', data: movie.toJson());
  }
}
