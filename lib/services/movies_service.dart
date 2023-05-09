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
        throw MoviesServiceException('Failed to load movies.');
      }
    } catch (e) {
      throw MoviesServiceException('Failed to load movies.');
    }
  }

  Future<List<MovieSession>> getMovieSessions(
      {required Movie movie, required DateTime date}) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await _dio.get(
        '$apiUrl/api/movies/sessions',
        queryParameters: {
          'movieId': movie.id,
          'date': formattedDate,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200) {
        final List<MovieSession> sessions = (response.data['data'] as List)
            .map((json) => MovieSession.fromJson(json, movie))
            .toList();
        return sessions;
      } else {
        throw MoviesServiceException('Failed to load movie sessions.');
      }
    } catch (e) {
      throw MoviesServiceException('Failed to load movie sessions.');
    }
  }

  Future<MovieSession?> getMovieSessionById(
      {required Movie movie, required int sessionId}) async {
    try {
      final response = await _dio.get(
        '$apiUrl/api/movies/sessions/$sessionId',
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200) {
        return MovieSession.fromJson(response.data['data'], movie);
      } else {
        throw MoviesServiceException('Failed to load movie session.');
      }
    } catch (e) {
      throw MoviesServiceException('Failed to load movie session.');
    }
  }

  Future<bool> bookSeats(
      {required Set<Seat> seats, required int sessionId}) async {
    try {
      List<int> seatIds = seats.map((seat) => seat.id).toList();

      final response = await _dio.post(
        '$apiUrl/api/movies/book',
        data: {
          'seats': seatIds,
          'sessionId': sessionId,
        },
        options: Options(headers: {
          'Authorization': 'Bearer ${authCubit.state.accessToken}',
        }),
      );

      if (response.statusCode == 200 && response.data['success']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw MoviesServiceException('Failed to book seats.');
    }
  }
}

class MoviesServiceException implements Exception {
  final String message;

  MoviesServiceException(this.message);

  @override
  String toString() {
    return 'MoviesServiceException: $message';
  }
}
