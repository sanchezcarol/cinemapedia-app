

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_reposity_provider.dart';

final movieProvider = StateNotifierProvider<MovieNotifier, Map<String,Movie>>((ref) {

  return MovieNotifier(
    getMovie: ref.watch(movieRepositoryProvider).getMovieById  );

});

typedef GetMovieCallback = Future<Movie>Function(String id);

class MovieNotifier extends StateNotifier<Map<String,Movie>> {
  
  final GetMovieCallback getMovie ;
  
  MovieNotifier({required this.getMovie}):super({});

  Future<void> loadMovie(String id) async {

    if(state[id] != null ) return;
    final movie = await getMovie(id);
    state = {...state, id: movie};
  }


}