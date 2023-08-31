

//State Notifier Provider => provider que notifica el cambio de estado

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_reposity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {

  return MovieNotifier(
    getMovies: ref.watch(movieRepositoryProvider).getNowPlaying
  );

});

typedef MovieCallback = Future<List<Movie>> Function({int page});
//                    = getNowPlaying(({int page})) 

class MovieNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback getMovies; 

  MovieNotifier({ required this.getMovies}): super([]);
  
  Future <void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await getMovies(page:currentPage);
    state = [...state, ...movies];
    
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }


}