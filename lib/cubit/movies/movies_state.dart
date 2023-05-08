part of 'movies_cubit.dart';

@immutable
class MoviesState {
  final Map<int, Movie> _movies;
  final MovieSession? _movieSession;
  final Set<Seat>? _selectedSeats;

  const MoviesState(
      {required Map<int, Movie> movies,
      MovieSession? movieSession,
      Set<Seat>? selectedSeats})
      : _movies = movies,
        _movieSession = movieSession,
        _selectedSeats = selectedSeats;

  // Public getters
  Map<int, Movie> get movies => _movies;
  MovieSession? get movieSession => _movieSession;
  Set<Seat>? get selectedSeats => _selectedSeats;
}
