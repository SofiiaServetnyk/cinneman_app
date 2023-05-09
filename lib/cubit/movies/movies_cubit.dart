import 'package:bloc/bloc.dart';
import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/data/models/movies.dart';
import 'package:cinneman/data/models/session_models.dart';
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
    Map<int, Movie> movies = {for (var movie in moviesList) movie.id: movie};

    emit(MoviesState(
        movies: movies,
        movieSession: state.movieSession,
        selectedSeats: state.selectedSeats));
  }

  Future<void> selectSession(MovieSession session) async {
    emit(MoviesState(
        movies: state.movies, movieSession: session, selectedSeats: {}));
  }

  Future<void> updateSession() async {
    try {
      MovieSession? movieSession = await movieService.getMovieSessionById(
          movie: state.movieSession!.movie, sessionId: state.movieSession!.id);
      if (movieSession != null) {
        emit(MoviesState(
            movies: state.movies,
            movieSession: movieSession,
            selectedSeats: state.selectedSeats));
      } else {
        throw MoviesServiceException("Error updating session data.");
      }
    } catch (e) {
      throw MoviesServiceException("Error updating session data.");
    }
  }

  Future<void> clearSession() async {
    emit(MoviesState(
        movies: state.movies, movieSession: null, selectedSeats: null));
  }

  Future<void> toggleSeat(Seat seat) async {
    Set<Seat>? seatsSet = state.selectedSeats;

    if (seatsSet == null) {
      seatsSet = {seat};
    } else if (seatsSet.contains(seat)) {
      seatsSet.remove(seat);
    } else {
      seatsSet.add(seat);
    }

    emit(MoviesState(
        movies: state.movies,
        movieSession: state.movieSession,
        selectedSeats: seatsSet));
  }
}
