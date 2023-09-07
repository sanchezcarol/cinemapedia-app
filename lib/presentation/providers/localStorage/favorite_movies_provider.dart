import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/localStorage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final storageRepository = ref.watch(localStorageRepositoryProvider);
  return storageRepository.isMovieFavorite(movieId);
});


final favoriteMoviesProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) { 
  final repository = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRepository: repository);
});

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>>{
  int currentPage = 0;
  bool isLoading = false;
  final LocalStorageRepository localStorageRepository;

  FavoriteMoviesNotifier({required this.localStorageRepository}):super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.favoritesMovies(offset: currentPage * 10, limit: 20 );
    currentPage++;

    final tempMovies = <int, Movie>{};
    for (final movie in movies) {
      tempMovies[movie.id] = movie; 
    }
    state = {...state, ...tempMovies};
    return movies;
  }

   Future<void> toggleFavorite( Movie movie ) async { 
    await localStorageRepository.toggleMovieFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if ( isMovieInFavorites ) {
      state.remove(movie.id);
      state = { ...state };
    } else {
      state = { ...state, movie.id: movie };
    }

  }
  




}