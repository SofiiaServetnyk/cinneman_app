import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/data/models/movies.dart';
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

  // Future<Movie?> getMovieById(int id) async {
  //   final movies = await getMovies();
  //   final movie = movies.firstWhere((movie) => movie.id == id);
  //   return movie;
  // }
}
