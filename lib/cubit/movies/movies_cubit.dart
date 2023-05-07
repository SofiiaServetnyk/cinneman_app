import 'package:bloc/bloc.dart';
import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/data/models/movies.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:meta/meta.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final AuthCubit authCubit;
  final MovieService movieService;

  MoviesCubit(this.authCubit)
      : this.movieService = MovieService(authCubit),
        super(MoviesState(movies: {}));

  Future<void> loadMovies() async {
    var moviesList = await movieService.getMovies();
    Map<int, Movie> movies = Map.fromIterable(
      moviesList,
      key: (movie) => movie.id,
      value: (movie) => movie,
    );

    emit(MoviesState(movies: movies));
  }
}
