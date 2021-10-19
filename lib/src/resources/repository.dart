import 'package:flutter_bloc_learn/src/injection/injection.dart';
import 'package:flutter_bloc_learn/src/models/state.dart';
import 'package:flutter_bloc_learn/src/resources/movie_api_provider.dart';
import 'package:injectable/injectable.dart';

@singleton
class Repository {
  final _moviesApiProvider = getIt<MovieApiProvider>();

  Future<State> fetchAllMovies() => _moviesApiProvider.fetchMovieList();
  Future<State> fetchTrailers(int movieId) =>
      _moviesApiProvider.fetchTrailer(movieId);
}
