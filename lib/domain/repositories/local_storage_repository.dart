
import '../entities/movie.dart';

abstract class LocalStorageRepository {

  Future<void> toggleMovieFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> favoritesMovies({int limit = 10, offset = 0});


}