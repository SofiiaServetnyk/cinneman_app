import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/data/models/movies.dart';
import 'package:cinneman/data/models/session_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class MovieService {
  final Dio _dio = Dio();
  AuthCubit authCubit;
  static String apiUrl = dotenv.env['API_URL']!;

  MovieService(this.authCubit);

  Future<List<Movie>> getMovies() async {
    try {
      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final response = await _dio.get(
        '$apiUrl/api/movies',
        queryParameters: {
          'date': currentDate,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200) {
        final List<Movie> movies = (response.data['data'] as List)
            .map((json) => Movie.fromJson(json))
            .toList();
        return movies;
      } else {
        return [];
        // throw Exception('Failed to load movies');
      }
    } catch (e) {
      // throw Exception('Failed to load movies: $e');
      return [];
    }
  }

  Future<List<MovieSession>> getMovieSessions(
      {required int movieId, required DateTime date}) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await _dio.get(
        '$apiUrl/api/movies/sessions',
        queryParameters: {
          'movieId': movieId,
          'date': formattedDate,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200) {
        final List<MovieSession> sessions = (response.data['data'] as List)
            .map((json) => MovieSession.fromJson(json))
            .toList();
        return sessions;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<MovieSession?> getMovieSessionById(int sessionId) async {
    try {
      final response = await _dio.get(
        '$apiUrl/api/movies/sessions/$sessionId',
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200) {
        return MovieSession.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
